json.extract! person, :id, :firstname, :lastname, :dni, :dni_sex, :self_perceived_sex, :birthdate, :phone, :email, :condition, :population_group, :locality_id, :address_street, :address_number, :address_floor, :address_department, :created_at, :updated_at
json.url person_url(person, format: :json)
