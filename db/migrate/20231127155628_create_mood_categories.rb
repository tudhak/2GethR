class CreateMoodCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :mood_categories do |t|
      t.string :title
      t.string :image_path

      t.timestamps
    end
  end
end
