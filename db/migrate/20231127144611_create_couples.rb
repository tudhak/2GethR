class CreateCouples < ActiveRecord::Migration[7.1]
  def change
    create_table :couples do |t|
      t.string :address
      t.integer :token

      t.timestamps
    end
  end
end
