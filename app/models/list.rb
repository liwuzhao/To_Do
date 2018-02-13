class List < ApplicationRecord
  belongs_to :user

  has_one :should_do
end
