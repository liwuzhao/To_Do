class List < ApplicationRecord
  belongs_to :user

  has_many :content
end
