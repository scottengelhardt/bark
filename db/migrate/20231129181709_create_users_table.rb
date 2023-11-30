class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, required: true, unique: true
      t.string :password_digest
      t.string :first
      t.string :last
      t.timestamps
    end
  end
end
