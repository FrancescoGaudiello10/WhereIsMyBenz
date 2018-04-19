require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get profile" do
    get pages_profile_url
    assert_response :success
  end

  test "should get settings" do
    get pages_settings_url
    assert_response :success
  end

  test "should get search" do
    get pages_search_url
    assert_response :success
  end

  test "should get add" do
    get pages_add_url
    assert_response :success
  end

  test "should get statistics" do
    get pages_statistics_url
    assert_response :success
  end

  test "should get results" do
    get pages_results_url
    assert_response :success
  end

  test "should get details" do
    get pages_details_url
    assert_response :success
  end

  test "should get calculate" do
    get pages_calculate_url
    assert_response :success
  end

end
