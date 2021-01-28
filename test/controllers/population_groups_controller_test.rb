require 'test_helper'

class PopulationGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @population_group = population_groups(:one)
  end

  test "should get index" do
    get population_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_population_group_url
    assert_response :success
  end

  test "should create population_group" do
    assert_difference('PopulationGroup.count') do
      post population_groups_url, params: { population_group: { code: @population_group.code, description: @population_group.description, priority: @population_group.priority } }
    end

    assert_redirected_to population_group_url(PopulationGroup.last)
  end

  test "should show population_group" do
    get population_group_url(@population_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_population_group_url(@population_group)
    assert_response :success
  end

  test "should update population_group" do
    patch population_group_url(@population_group), params: { population_group: { code: @population_group.code, description: @population_group.description, priority: @population_group.priority } }
    assert_redirected_to population_group_url(@population_group)
  end

  test "should destroy population_group" do
    assert_difference('PopulationGroup.count', -1) do
      delete population_group_url(@population_group)
    end

    assert_redirected_to population_groups_url
  end
end
