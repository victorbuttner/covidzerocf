class RemoveFieldFromProjects < ActiveRecord::Migration[6.0]
  def change

    remove_column :projects, :quota_total, :integer

    remove_column :projects, :active, :boolean

    remove_column :projects, :tip1, :string

    remove_column :projects, :tip2, :string

    remove_column :projects, :tip3, :string

    remove_column :projects, :tip4, :string
  end
end
