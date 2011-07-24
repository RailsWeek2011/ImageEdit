require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

end
