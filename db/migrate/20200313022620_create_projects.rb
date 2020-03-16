class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :photo
      t.decimal :goal
      t.integer :quota_total
      t.decimal :quota_value
      t.string :slug
      t.boolean :active

      t.timestamps
    end
  end
end
