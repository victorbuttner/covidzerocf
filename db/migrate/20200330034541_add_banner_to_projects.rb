class AddBannerToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :banner, :string
  end
end
