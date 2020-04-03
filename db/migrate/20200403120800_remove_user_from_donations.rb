class RemoveUserFromDonations < ActiveRecord::Migration[6.0]
  def change

    remove_column :donations, :user_id, :bigint
  end
end
