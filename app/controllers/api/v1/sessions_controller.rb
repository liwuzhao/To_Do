class API::V1::SessionsController < API::V1::BaseController
  skip_before_action :ensure_authenticated_user

  def create
    if @session = authenticate_session
      render_created
    else
      render_unauthorized('登录失败, 请重试')
    end
  end

  private

  def authenticate_session
    if (auth_data = fetch_auth_data) && auth_data.valid?
      User.authenticate!(auth_data)
    end
  rescue ActiveRecord::RecordInvalid => exception
    logger.error "#{exception.class.name} (#{exception.message}):"
    logger.error exception.backtrace.join("\n")
    false
  end

  def fetch_auth_data
    Wechat::Weapp.fetch_auth_data(
      params[:code],
      params[:encrypted_data],
      params[:iv]
    )
  rescue Wechat::Weapp::Error
    nil
  end
end
