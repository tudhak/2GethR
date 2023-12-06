class AddEmojiToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :emoji, :string
  end
end
