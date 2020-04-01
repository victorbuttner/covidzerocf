class AddTipsToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :tip1, :string
    add_column :projects, :tip2, :string
    add_column :projects, :tip3, :string
    add_column :projects, :tip4, :string
  end
end
