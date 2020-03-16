class AddAboutToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :about, :string
  end
end
