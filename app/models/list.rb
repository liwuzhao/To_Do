class List < ApplicationRecord
  belongs_to :user
  has_many :should_dos

  validate :validate_should_dos_quantity


  def validate_should_dos_quantity
    if self.should_dos.length > 3
      errors.add(:should_dos, "can't over 3 should_dos")
    end
  end

  def validate_has_one_list_in_same_day
    now = Time.now().to_s
    List.all.order(created_at: :desc).each do |list|
      if list.list_date.to_s == now
        errors.add(:list, "had create list today")
      end
    end
    return true
  end

end
