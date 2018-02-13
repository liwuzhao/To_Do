class API::V1::ListsController < API::V1::BaseController
  # skip_before_action :ensure_authenticated_user

  def index
    @lists = @current_user.lists
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
      should_do = list.should_do || ShouldDo.new
      should_do.assign_attributes(params[:list][:should_do].permit(:content))
      list.should_do = should_do
    end
end
