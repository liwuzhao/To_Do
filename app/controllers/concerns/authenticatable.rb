module Authenticatable
  extend ActiveSupport::Concern

  class_methods do
    def authenticate!(auth_data)
      self.transaction do
        user = self.find_or_create_by!(union_id: auth_data.union_id)

        identity = user.identities.find_or_create_by!(auth_data.identity_data)

        session = identity.sessions.create!(auth_data.session_data)

        if user.profile.nil?
          user.create_profile!(auth_data.profile_data)
        else
          user.profile.update!(auth_data.profile_data)
        end

        session
      end
    end
  end
end
