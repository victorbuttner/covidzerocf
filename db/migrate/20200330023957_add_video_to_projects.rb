class AddVideoToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :video_url, :string
  end
end
