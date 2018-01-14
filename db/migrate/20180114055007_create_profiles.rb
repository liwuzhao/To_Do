class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :nick_name
      t.integer :gender, default: 0
      t.string :language
      t.string :city
      t.string :province
      t.string :country
      t.string :avatar_url
      t.timestamps
    end
  end
end
