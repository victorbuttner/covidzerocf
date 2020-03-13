class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :cpf, :string
    add_column :users, :phone, :string
    add_column :users, :address_zipcode, :string
    add_column :users, :address_city, :string
    add_column :users, :address_neighborhood, :string
    add_column :users, :address_state, :string
    add_column :users, :address_street, :string
    add_column :users, :address_street_number, :integer
    add_column :users, :address_complement, :string
  end
end
