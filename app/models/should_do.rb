class ShouldDo < ApplicationRecord
  belongs_to :list

  validates :content, presence: true

  enum status: { '未完成' => 0, '完成' => 1}

  def done!
    update status: 1
  end

  def undone
    update status: 0
  end
end
