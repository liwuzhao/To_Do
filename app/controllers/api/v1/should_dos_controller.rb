class API::V1::ShouldDosController < API::V1::BaseController

  def index
    @should_dos = ShouldDo.all
  end

  def update
    @should_do = ShouldDo.find(params[:id])
    if @should_do.status == "未完成"
      @should_do.done!
    else
      render_forbidden
    end
  end

end
