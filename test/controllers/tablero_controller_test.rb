require 'test_helper'

class TableroControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tablero_index_url
    assert_response :success
  end

end
