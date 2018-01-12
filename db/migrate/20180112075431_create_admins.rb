class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins, comment: '管理员' do |t| #修改
      t.string :name, null: false, comment: '账号' #新增
      t.string :password_digest, null: false, comment: '密码' #新增

      t.timestamps
    end
    add_index :admins, :name, unique: true #新增
  end
end
