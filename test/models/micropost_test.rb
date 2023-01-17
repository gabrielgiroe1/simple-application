require "test_helper"

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:matei)
    @micropost = @user.microposts.new(connect: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    asset @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
end
