class Profile < ApplicationRecord
  enum gender: { '未知' => 0, '男' => 1, '女' => 2 }

  belongs_to :user, inverse_of: :profile

  validates :nick_name, presence: true
end
