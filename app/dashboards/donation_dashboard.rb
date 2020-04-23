require "administrate/base_dashboard"

class DonationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    project: Field::BelongsTo,
    id: Field::Number,
    value: Field::String.with_options(searchable: false),
    payment_status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    email: Field::String,
    cpf: Field::String,
    user_name: Field::String,
    birthdate: Field::DateTime,
    phone: Field::String,
    first_name: Field::String,
    surname: Field::String,
    address_street: Field::String,
    address_number: Field::Number,
    address_zipcode: Field::String,
    address_reference: Field::String,
    address_district: Field::String,
    address_city: Field::String,
    address_state: Field::String,
    address_country: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  project
  id
  value
  payment_status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  project
  id
  value
  payment_status
  created_at
  updated_at
  email
  cpf
  user_name
  birthdate
  phone
  first_name
  surname
  address_street
  address_number
  address_zipcode
  address_reference
  address_district
  address_city
  address_state
  address_country
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  project
  value
  payment_status
  email
  cpf
  user_name
  birthdate
  phone
  first_name
  surname
  address_street
  address_number
  address_zipcode
  address_reference
  address_district
  address_city
  address_state
  address_country
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how donations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(donation)
  #   "Donation ##{donation.id}"
  # end
end
