class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :union_id
      t.timestamps
    end
    add_index :users, :union_id, unique: true 
  end
end
