require "application_system_test_case"

class PopulationGroupsTest < ApplicationSystemTestCase
  setup do
    @population_group = population_groups(:one)
  end

  test "visiting the index" do
    visit population_groups_url
    assert_selector "h1", text: "Population Groups"
  end

  test "creating a Population group" do
    visit population_groups_url
    click_on "New Population Group"

    fill_in "Code", with: @population_group.code
    fill_in "Description", with: @population_group.description
    fill_in "Priority", with: @population_group.priority
    click_on "Create Population group"

    assert_text "Population group was successfully created"
    click_on "Back"
  end

  test "updating a Population group" do
    visit population_groups_url
    click_on "Edit", match: :first

    fill_in "Code", with: @population_group.code
    fill_in "Description", with: @population_group.description
    fill_in "Priority", with: @population_group.priority
    click_on "Update Population group"

    assert_text "Population group was successfully updated"
    click_on "Back"
  end

  test "destroying a Population group" do
    visit population_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Population group was successfully destroyed"
  end
end
