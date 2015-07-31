class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :completed
      t.string :country
      t.string :uuid

      t.timestamps null: false
    end
  end
end
