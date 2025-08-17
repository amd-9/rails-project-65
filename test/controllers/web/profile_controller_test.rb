require "test_helper"

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_profile_index_url
    assert_response :success
  end
end
