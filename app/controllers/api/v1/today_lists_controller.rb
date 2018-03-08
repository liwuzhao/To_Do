class API::V1::TodayListsController < API::V1::BaseController
  # skip_before_action :ensure_authenticated_user

  def show
    @list = find_today_list(@current_user.lists)
  end

  private

  def find_today_list(lists)
    now = Time.now().to_s
    lists = lists.order(created_at: :desc)
    lists.each do |l|
      if l.list_date.to_s == now
        return l
      end
    end
    return nil
  end

end
