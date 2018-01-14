module APIAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated_user
  end

  private

  def ensure_authenticated_user
    unless authenticate_user
      render_unauthorized('在继续操作之前请先登录')
    end
  end

  def current_session
    if request.headers['Authorization'].present?
      auth_data = AuthToken.decode(request.headers['Authorization'])
      Session.unexpired.find_by(sid: auth_data['sid'])
    end
  rescue AuthToken::DecodeError
    nil
  end

  def authenticate_user
    if (session = current_session)
      session.refresh_expiration
      @current_user = session.user
    end
  end

  def unauthenticate_user
    if (session = current_session)
      session.mark_as_expired
      @current_user = nil
    end
  end
end
