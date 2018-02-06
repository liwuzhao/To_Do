class CreateShouldDos < ActiveRecord::Migration[5.1]
  def change
    create_table :should_dos do |t|
      t.references :list, foreign_key: true
      t.text :content
      t.timestamps
    end
  end
end
