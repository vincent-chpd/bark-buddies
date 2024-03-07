require "test_helper"

class DogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get dogs_create_url
    assert_response :success
  end

  test "should get show" do
    get dogs_show_url
    assert_response :success
  end

  test "should get update" do
    get dogs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get dogs_destroy_url
    assert_response :success
  end
end
