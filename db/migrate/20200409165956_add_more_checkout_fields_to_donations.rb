class AddMoreCheckoutFieldsToDonations < ActiveRecord::Migration[6.0]
  def change
    add_column :donations, :first_name, :string
    add_column :donations, :surname, :string
    add_column :donations, :address_street, :string
    add_column :donations, :address_number, :integer
    add_column :donations, :address_zipcode, :string
    add_column :donations, :address_reference, :string
    add_column :donations, :address_district, :string
    add_column :donations, :address_city, :string
    add_column :donations, :address_state, :string
    add_column :donations, :address_country, :string
  end
end
