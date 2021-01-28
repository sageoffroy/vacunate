require "application_system_test_case"

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:one)
  end

  test "visiting the index" do
    visit people_url
    assert_selector "h1", text: "People"
  end

  test "creating a Person" do
    visit people_url
    click_on "New Person"

    fill_in "Address department", with: @person.address_department
    fill_in "Address floor", with: @person.address_floor
    fill_in "Address number", with: @person.address_number
    fill_in "Address street", with: @person.address_street
    fill_in "Birthdate", with: @person.birthdate
    check "Condition" if @person.condition
    fill_in "Dni", with: @person.dni
    fill_in "Dni sex", with: @person.dni_sex
    fill_in "Email", with: @person.email
    fill_in "Firstname", with: @person.firstname
    fill_in "Lastname", with: @person.lastname
    fill_in "Locality", with: @person.locality_id
    fill_in "Population group", with: @person.population_group_id
    fill_in "Self perceived sex", with: @person.self_perceived_sex
    fill_in "State", with: @person.state_id
    fill_in "Telephone", with: @person.telephone
    click_on "Create Person"

    assert_text "Person was successfully created"
    click_on "Back"
  end

  test "updating a Person" do
    visit people_url
    click_on "Edit", match: :first

    fill_in "Address department", with: @person.address_department
    fill_in "Address floor", with: @person.address_floor
    fill_in "Address number", with: @person.address_number
    fill_in "Address street", with: @person.address_street
    fill_in "Birthdate", with: @person.birthdate
    check "Condition" if @person.condition
    fill_in "Dni", with: @person.dni
    fill_in "Dni sex", with: @person.dni_sex
    fill_in "Email", with: @person.email
    fill_in "Firstname", with: @person.firstname
    fill_in "Lastname", with: @person.lastname
    fill_in "Locality", with: @person.locality_id
    fill_in "Population group", with: @person.population_group_id
    fill_in "Self perceived sex", with: @person.self_perceived_sex
    fill_in "State", with: @person.state_id
    fill_in "Telephone", with: @person.telephone
    click_on "Update Person"

    assert_text "Person was successfully updated"
    click_on "Back"
  end

  test "destroying a Person" do
    visit people_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Person was successfully destroyed"
  end
end
