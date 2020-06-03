require 'test_helper'

class PhrasesControllerTest < ActionDispatch::IntegrationTest
  test "should get :new" do
    get phrases_:new_url
    assert_response :success
  end

  test "should get :create" do
    get phrases_:create_url
    assert_response :success
  end

  test "should get :index" do
    get phrases_:index_url
    assert_response :success
  end

end
