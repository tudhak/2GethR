class AddRejectedByToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :rejected_by, :integer, array: true, default: []
  end
end
