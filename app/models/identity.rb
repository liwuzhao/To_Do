class Identity < ApplicationRecord
  has_many :sessions, dependent: :destroy
  belongs_to :user

  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true
end
