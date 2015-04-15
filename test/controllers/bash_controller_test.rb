require 'test_helper'

class BashControllerTest < ActionController::TestCase
  test "should get /dev/fd/63" do
    get :/dev/fd/63
    assert_response :success
  end

end
