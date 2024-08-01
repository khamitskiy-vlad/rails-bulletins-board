require "test_helper"

class Web::Admin::PanelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_index_url
    assert_response :success
  end
end
