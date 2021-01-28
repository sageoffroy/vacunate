require "application_system_test_case"

class PathologiesTest < ApplicationSystemTestCase
  setup do
    @pathology = pathologies(:one)
  end

  test "visiting the index" do
    visit pathologies_url
    assert_selector "h1", text: "Pathologies"
  end

  test "creating a Pathology" do
    visit pathologies_url
    click_on "New Pathology"

    fill_in "Code", with: @pathology.code
    fill_in "Description", with: @pathology.description
    fill_in "Priority", with: @pathology.priority
    click_on "Create Pathology"

    assert_text "Pathology was successfully created"
    click_on "Back"
  end

  test "updating a Pathology" do
    visit pathologies_url
    click_on "Edit", match: :first

    fill_in "Code", with: @pathology.code
    fill_in "Description", with: @pathology.description
    fill_in "Priority", with: @pathology.priority
    click_on "Update Pathology"

    assert_text "Pathology was successfully updated"
    click_on "Back"
  end

  test "destroying a Pathology" do
    visit pathologies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pathology was successfully destroyed"
  end
end
