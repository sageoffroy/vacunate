class AddAreaToLocality < ActiveRecord::Migration[5.2]
  def change
    add_reference :localities, :area, foreign_key: true
  end
end
