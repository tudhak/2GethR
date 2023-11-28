require "test_helper"

class CouplesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get couples_index_url
    assert_response :success
  end

  test "should get show" do
    get couples_show_url
    assert_response :success
  end

  test "should get new" do
    get couples_new_url
    assert_response :success
  end

  test "should get create" do
    get couples_create_url
    assert_response :success
  end

  test "should get edit" do
    get couples_edit_url
    assert_response :success
  end

  test "should get update" do
    get couples_update_url
    assert_response :success
  end

  test "should get destroy" do
    get couples_destroy_url
    assert_response :success
  end
end
