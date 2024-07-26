class AddNicknameToCouples < ActiveRecord::Migration[7.1]
  def change
    add_column :couples, :nickname, :string
  end
end
