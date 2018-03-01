class List < ApplicationRecord
  belongs_to :user

  has_many :should_dos

  validate :validate_should_dos_quantity

  def validate_should_dos_quantity
    if self.should_dos.length > 3
      errors.add(:should_dos, "can't over 3 should_dos")
    end
  end

end
