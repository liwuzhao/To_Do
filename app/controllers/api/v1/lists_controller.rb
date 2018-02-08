class API::V1::ListsController < API::V1::BaseController
  skip_before_action :ensure_authenticated_user

  def index
    @lists = List.all
  end

  def create
    @list = @current_user.list.bulid
    assign_should_do(@list)

    if @list.save
      render_created
    end

  end

  private

    def assign_should_do(list)
      should_do = ShouldDo.new
      should_do.assign_attributes(params[:list][:should_do].permit(:content))
      list.should_do = should_do
    end
end
