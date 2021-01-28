class CreatePathologies < ActiveRecord::Migration[5.2]
  def change
    create_table :pathologies do |t|
      t.integer :code
      t.integer :priority
      t.string :description

      t.timestamps
    end
  end
end
