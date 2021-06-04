class CreatePeopleWithLocalityAndStates < ActiveRecord::Migration[5.2]
  def change
    create_view :people_with_locality_and_states
  end
end
