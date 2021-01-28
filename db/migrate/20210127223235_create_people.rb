class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.integer :dni
      t.string :dni_sex
      t.string :self_perceived_sex
      t.date :birthdate
      t.integer :phone_code
      t.integer :phone
      t.string :email
      t.boolean :condition
      t.string :population_group
      t.boolean :obesity
      t.boolean :diabetes
      t.boolean :chronic_kidney_disease
      t.boolean :cardiovascular_disease
      t.boolean :chronic_lung_disease

      t.references :locality, foreign_key: true
      t.string :address_street
      t.integer :address_number
      t.integer :address_floor
      t.string :address_department
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
