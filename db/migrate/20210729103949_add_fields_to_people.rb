class AddFieldsToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :neurological_disease, :boolean
    add_column :people, :cud, :boolean
    remove_column :people, :boolean, :string
  end
end
