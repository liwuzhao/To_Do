class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.references :identity, foreign_key: true
      t.string :sid
      t.string :session_key
      t.datetime :expires_at
      t.timestamps
    end
    add_index :sessions, :sid, unique: true
  end
end
