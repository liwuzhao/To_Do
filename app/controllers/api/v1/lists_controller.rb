class API::V1::ListController < API::VI::BaseController

  def index
    @lists = @current_user.lists
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
