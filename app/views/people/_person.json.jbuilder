json.extract! person, :id, :firstname, :lastname, :dni, :dni_sex, :self_perceived_sex, :birthdate, :telephone, :email, :condition, :population_group_id, :locality_id, :address_street, :address_number, :address_floor, :address_department, :state_id, :created_at, :updated_at
json.url person_url(person, format: :json)
