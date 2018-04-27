require 'test_helper'

class CalcsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calcs_index_url
    assert_response :success
  end

end
