class AddWishlistToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :wishlist, :string
  end
end
