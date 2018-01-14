module APIRenderingHelper
  extend ActiveSupport::Concern

  def render_ok(template = nil)
    if ::Hash === template
      render json: template, status: :ok
    else
      template ||= action_name
      render template, status: :ok
    end
  end

  def render_created(template = nil)
    if ::Hash === template
      render json: template, status: :created
    else
      template ||= action_name
      render template, status: :created
    end
  end

  def render_no_content
    head :no_content
  end

  def render_bad_request(message = nil)
    message ||= '请求参数不合法'
    render json: { message: message }, status: :bad_request
  end

  def render_unauthorized(message = nil)
    message ||= '你还未登录'
    render json: { message: message }, status: :unauthorized
  end

  def render_forbidden(message = nil)
    message ||= '你无法进行该操作'
    render json: { message: message }, status: :forbidden
  end

  def render_not_found(message = nil)
    message ||= '你要操作的资源未找到'
    render json: { message: message }, status: :not_found
  end

  def render_unprocessable_entity(message = nil, record = nil)
    message ||= '验证失败'
    if record.nil?
      errors = []
    else
      errors = record.errors.keys.map do |attribute|
        error_message = record.errors[attribute].first
        full_error_message = record.errors.full_message(attribute, error_message)
        {
          resource: record.class.name,
          field: attribute.to_s,
          message: full_error_message
        }
      end
    end
    render json: { message: message, errors: errors }, status: :unprocessable_entity
  end

  def render_internal_server_error(message = nil)
    message ||= '服务器开小差'
    render json: { message: message }, status: :internal_server_error
  end
end
