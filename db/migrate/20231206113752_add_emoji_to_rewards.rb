class AddEmojiToRewards < ActiveRecord::Migration[7.1]
  def change
    add_column :rewards, :emoji, :string
  end
end
