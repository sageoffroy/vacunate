class AddInmuunocompromisedToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :inmunocompromised, :string
    add_column :people, :boolean, :string
  end
end
