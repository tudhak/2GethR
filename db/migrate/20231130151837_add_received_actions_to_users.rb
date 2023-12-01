class AddReceivedActionsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :received_actions, :string
  end
end
