require "test_helper"

class QuizAttemptsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get quiz_attempts_new_url
    assert_response :success
  end

  test "should get create" do
    get quiz_attempts_create_url
    assert_response :success
  end
end
