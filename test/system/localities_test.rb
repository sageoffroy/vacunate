require "application_system_test_case"

class LocalitiesTest < ApplicationSystemTestCase
  setup do
    @locality = localities(:one)
  end

  test "visiting the index" do
    visit localities_url
    assert_selector "h1", text: "Localities"
  end

  test "creating a Locality" do
    visit localities_url
    click_on "New Locality"

    fill_in "Name", with: @locality.name
    fill_in "Postal code", with: @locality.postal_code
    click_on "Create Locality"

    assert_text "Locality was successfully created"
    click_on "Back"
  end

  test "updating a Locality" do
    visit localities_url
    click_on "Edit", match: :first

    fill_in "Name", with: @locality.name
    fill_in "Postal code", with: @locality.postal_code
    click_on "Update Locality"

    assert_text "Locality was successfully updated"
    click_on "Back"
  end

  test "destroying a Locality" do
    visit localities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Locality was successfully destroyed"
  end
end
