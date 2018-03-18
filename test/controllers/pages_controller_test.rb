require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_index_url
    assert_response :success
  end

  test "should get new" do
    get pages_new_url
    assert_response :success
  end

  test "should get crate" do
    get pages_crate_url
    assert_response :success
  end

end
