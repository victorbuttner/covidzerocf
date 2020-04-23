require "administrate/base_dashboard"

class ProjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    donations: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    photo: Field::Carrierwave,
    goal: Field::String.with_options(searchable: false),
    quota_value: Field::String.with_options(searchable: false),
    slug: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    about: Field::String,
    video_url: Field::String,
    banner: Field::Carrierwave,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  donations
  id
  name
  photo
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  donations
  id
  name
  photo
  goal
  quota_value
  slug
  created_at
  updated_at
  about
  video_url
  banner
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  donations
  name
  photo
  goal
  quota_value
  slug
  about
  video_url
  banner
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

  # Overwrite this method to customize how projects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(project)
  #   "Project ##{project.id}"
  # end
end
