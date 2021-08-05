class AddPregnantToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :pregnant, :boolean
  end
end
