class UpdateUsers2 < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string, presence: true
    add_index :users, :username, unique: true
  end
end
