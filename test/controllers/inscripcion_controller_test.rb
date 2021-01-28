require 'test_helper'

class InscripcionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inscripcion_index_url
    assert_response :success
  end

end
