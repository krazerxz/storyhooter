class AddTaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tale, :string
  end
end
