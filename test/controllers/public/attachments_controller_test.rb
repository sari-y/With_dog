require "test_helper"

class Public::AttachmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get public_attachments_destroy_url
    assert_response :success
  end
end
