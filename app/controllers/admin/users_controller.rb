class Admin::UsersController < Admin::BaseController
  def index
    @q = User.all.ransack(params[:q])
    @users = @q
      .result
      .order(created_at: :desc)
      .page(params[:page])
      .includes(:profile)
    @users_count = @q.result.count
  end

  def show
    @user = User.find(params[:id])
  end
end
