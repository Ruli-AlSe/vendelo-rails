require "test_helper"

class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:paco)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should login a user by email" do
    post sessions_url, params: { login: @user.email, password: "123456"  }

    assert_redirected_to products_url
  end

  test "should login a user by username" do
    post sessions_url, params: { login: @user.username, password: "123456"  }

    assert_redirected_to products_url
  end

  test "should logout a user" do
    login

    delete session_path(@user.id)
    assert_redirected_to products_path
    assert_equal flash[:notice], "Has cerrado sesion"
  end
end
