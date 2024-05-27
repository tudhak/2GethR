class ChangeTokenType < ActiveRecord::Migration[7.1]
  def change
    change_column :couples, :token, :string
  end
end
