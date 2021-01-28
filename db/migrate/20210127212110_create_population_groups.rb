class CreatePopulationGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :population_groups do |t|
      t.integer :code
      t.integer :priority
      t.string :description

      t.timestamps
    end
  end
end
