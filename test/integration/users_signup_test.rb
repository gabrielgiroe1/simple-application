require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid sign-up information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "email@invalid",
                                         password: "foo",
                                         password_confirmation: "bar"
      } }
    end
    assert_template 'users/new'
    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>'
  end

  test "valid sign-up information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "gabriel",
                                         email: "gabriel.giroe@ulbsibiu.ro",
                                         password: "123456",
                                         password_confirmation: "123456"
      } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
    assert is_logged_in?
  end
end