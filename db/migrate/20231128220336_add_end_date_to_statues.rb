class AddEndDateToStatues < ActiveRecord::Migration[7.1]
  def change
    add_column :statues, :end_date, :datetime
  end
end
