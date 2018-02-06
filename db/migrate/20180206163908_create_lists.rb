class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.references :user, foreign_key: true
      t.datetime :list_date, commit: '清单日期'
      t.timestamps
    end
  end
end
