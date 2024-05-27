class AddAutopilotToStatues < ActiveRecord::Migration[7.1]
  def change
    add_column :statues, :autopilot, :boolean, default: false
  end
end
