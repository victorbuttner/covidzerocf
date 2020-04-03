class AddCheckoutFieldsToDonations < ActiveRecord::Migration[6.0]
  def change
    add_column :donations, :email, :string
    add_column :donations, :cpf, :string
    add_column :donations, :user_name, :string
    add_column :donations, :birthdate, :date
    add_column :donations, :phone, :string
  end
end
