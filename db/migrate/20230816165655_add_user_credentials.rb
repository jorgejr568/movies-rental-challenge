class AddUserCredentials < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :users, :password, :string
  end

  add_index :users, :email, unique: true
end
