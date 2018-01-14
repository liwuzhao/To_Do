require 'openssl'
require 'base64'
require 'active_support/json'

module Wechat
  class Weapp
    class Error < StandardError
    end

    class AuthData
      attr_reader :union_id, :identity_data, :session_data, :profile_data

      def initialize(union_id, identity_data, session_data, profile_data)
        @union_id = union_id
        @identity_data = identity_data
        @session_data = session_data
        @profile_data = profile_data
      end

      def valid?
        self.union_id.present? &&
          self.identity_data.present? && self.identity_data[:provider].present? && self.identity_data[:uid].present? &&
          self.session_data.present? && self.session_data[:session_key].present? &&
          self.profile_data.present?
      end
    end

    class << self
      def jscode2session_uri(code)
        raise ArgumentError, 'code can not be empty' unless code.present?

        uri_options = {
          scheme: 'https',
          host: 'api.weixin.qq.com',
          path: '/sns/jscode2session',
          query_values: {
            appid: Figaro.env.WECHAT_WEAPP_APP_ID!,
            secret: Figaro.env.WECHAT_WEAPP_APP_SECRET!,
            js_code: code,
            grant_type: 'authorization_code'
          }
        }

        Addressable::URI.new(uri_options)
      end

      def jscode2session(code)
        url = jscode2session_uri(code)
        response = HTTP.timeout(:global, :write => 2, :connect => 5, :read => 5).get(url)

        unless response.status.success?
          Rails.logger.error "Request jscode2session failed: #{response.inspect}"
          raise Error, response.to_s
        end

        response = ActiveSupport::JSON.decode(response.body.to_s)

        if response['errcode'].present?
          Rails.logger.error "Request jscode2session failed: #{response.inspect}"
          raise Error, response['errmsg']
        end

        {
          open_id: response['openid'],
          session_key: response['session_key'],
          expires_in: response['expires_in']
        }.with_indifferent_access
      rescue HTTP::Error => exception
        Rails.logger.error "#{exception.class.name} (#{exception.message}):"
        Rails.logger.error exception.backtrace.join("\n")
        raise Error, exception.message
      end

      def decrypt_user_data(session_key, encrypted_data, iv)
        session_key = Base64.decode64(session_key)
        encrypted_data= Base64.decode64(encrypted_data)
        iv = Base64.decode64(iv)

        cipher = OpenSSL::Cipher::AES128.new(:CBC)
        cipher.decrypt
        cipher.key = session_key
        cipher.iv = iv

        decrypted = cipher.update(encrypted_data) + cipher.final
        decrypted_data = ActiveSupport::JSON.decode(decrypted)

        unless decrypted_data['watermark']['appid'] == Figaro.env.WECHAT_WEAPP_APP_ID!
          raise Error, 'Invalid buffer'
        end

        {
          union_id: decrypted_data['unionId'],
          open_id: decrypted_data['openId'],
          nick_name: decrypted_data['nickName'],
          gender: decrypted_data['gender'],
          language: decrypted_data['language'],
          city: decrypted_data['city'],
          province: decrypted_data['province'],
          country: decrypted_data['country'],
          avatar_url: decrypted_data['avatarUrl'],
        }.with_indifferent_access
      end

      def fetch_auth_data(code, encrypted_data, iv)
        response = jscode2session(code)
        user_data = decrypt_user_data(response[:session_key], encrypted_data, iv)

        union_id = user_data.delete(:union_id) || user_data.delete(:open_id)
        identity_data = {
          uid: user_data.delete(:open_id) || union_id,
          provider: 'wechat_weapp'
        }
        session_data = {
          session_key: response[:session_key],
        }
        profile_data = user_data

        AuthData.new(union_id, identity_data, session_data, profile_data)
      end
    end
  end
end
