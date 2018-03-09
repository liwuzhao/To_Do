class API::V1::ListsController < API::V1::BaseController
  # skip_before_action :ensure_authenticated_user
  before_action :validate_has_one_list_in_same_day, only: [:create]

  def index
    @lists = @current_user.lists.order(created_at: :desc).includes(:should_dos)
  end

  def create
    @list = @current_user.lists.new(params_list)
    assign_should_do(@list)
    if @list.save
      render_created
    else
      render_bad_request('发布失败')
    end

  end

  private

    def params_list
      params.require(:list).permit(:list_date)
    end

    def assign_should_do(list)
      params[:list][:should_dos].each do |should|
        should_do = list.should_dos.new
        should_do.assign_attributes(should.permit(:content, :status))
      end
    end

    def validate_has_one_list_in_same_day
      now = Time.now().to_s
      @current_user.lists.order(created_at: :desc).each do |list|
        if list.list_date.to_s == now
          render_unprocessable_entity('你今天已经创建过清单了')
        end
      end
      return true
    end

end
