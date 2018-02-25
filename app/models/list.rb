class List < ApplicationRecord
  belongs_to :user

  has_many :should_dos
end
