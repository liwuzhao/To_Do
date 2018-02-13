class User < ApplicationRecord
  include Authenticatable

  has_many :identities, dependent: :destroy
  has_many :sessions, through: :identities
  has_one :profile

  validates :union_id, presence: true, uniqueness: true

  PROFILE_ATTRIBUTES = %w(nick_name gender language city province country avatar_url)
  delegate *PROFILE_ATTRIBUTES, to: :profile, allow_nil: true

  has_many :lists, dependent: :destroy
end
