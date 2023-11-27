class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :nickname, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :score, :integer
    add_column :users, :mode, :string
    add_reference :users, :couple, foreign_key: true
  end
end
