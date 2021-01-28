require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post people_url, params: { person: { address_department: @person.address_department, address_floor: @person.address_floor, address_number: @person.address_number, address_street: @person.address_street, birthdate: @person.birthdate, condition: @person.condition, dni: @person.dni, dni_sex: @person.dni_sex, email: @person.email, firstname: @person.firstname, lastname: @person.lastname, locality_id: @person.locality_id, population_group_id: @person.population_group_id, self_perceived_sex: @person.self_perceived_sex, state_id: @person.state_id, telephone: @person.telephone } }
    end

    assert_redirected_to person_url(Person.last)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { address_department: @person.address_department, address_floor: @person.address_floor, address_number: @person.address_number, address_street: @person.address_street, birthdate: @person.birthdate, condition: @person.condition, dni: @person.dni, dni_sex: @person.dni_sex, email: @person.email, firstname: @person.firstname, lastname: @person.lastname, locality_id: @person.locality_id, population_group_id: @person.population_group_id, self_perceived_sex: @person.self_perceived_sex, state_id: @person.state_id, telephone: @person.telephone } }
    assert_redirected_to person_url(@person)
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete person_url(@person)
    end

    assert_redirected_to people_url
  end
end
