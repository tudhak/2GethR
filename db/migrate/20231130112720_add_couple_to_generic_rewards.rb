class AddCoupleToGenericRewards < ActiveRecord::Migration[7.1]
  def change
    add_reference(:generic_rewards, :couple, foreign_key: true)
  end
end
