class AddStartDateToStatues < ActiveRecord::Migration[7.1]
  def change
    add_column :statues, :start_date, :datetime
  end
end
