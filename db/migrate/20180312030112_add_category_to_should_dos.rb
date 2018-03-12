class AddCategoryToShouldDos < ActiveRecord::Migration[5.1]
  def change
    add_column :should_dos, :category, :string
  end
end
