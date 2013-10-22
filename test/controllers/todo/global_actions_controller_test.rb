require 'test_helper'

class Todo::GlobalActionsControllerTest < ActionController::TestCase
  test "should get translate" do
    get :translate
    assert_response :success
  end

end
