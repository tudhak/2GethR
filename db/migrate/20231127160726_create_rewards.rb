class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.text :description
      t.string :title
      t.integer :cost

      t.timestamps
    end
  end
end
