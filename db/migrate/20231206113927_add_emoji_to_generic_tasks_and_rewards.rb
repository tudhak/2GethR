class AddEmojiToGenericTasksAndRewards < ActiveRecord::Migration[7.1]
  def change
    add_column :generic_tasks, :emoji, :string
    add_column :generic_rewards, :emoji, :string
  end
end
