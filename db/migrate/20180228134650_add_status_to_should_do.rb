class AddStatusToShouldDo < ActiveRecord::Migration[5.1]
  def change
    add_column :should_dos, :status, :integer, default: 0
  end
end
