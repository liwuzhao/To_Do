require 'jwt'

class AuthToken
  class EncodeError < StandardError
  end

  class DecodeError < StandardError
  end

  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  rescue JWT::EncodeError => exception
    Rails.logger.error "#{exception.class.name} (#{exception.message}):"
    Rails.logger.error exception.backtrace.join("\n")
    raise EncodeError, exception.message
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  rescue JWT::DecodeError => exception
    Rails.logger.error "#{exception.class.name} (#{exception.message}):"
    Rails.logger.error exception.backtrace.join("\n")
    raise DecodeError, exception.message
  end
end
