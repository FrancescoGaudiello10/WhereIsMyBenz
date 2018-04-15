require 'test_helper'

class FeedbackControllerTest < ActionController::TestCase
  test "should get value:integer" do
    get :value:integer
    assert_response :success
  end

end
