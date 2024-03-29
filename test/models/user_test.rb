require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new( name: "Gabi", email: "gabi@gmail.com",
                      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be to long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be to long" do
    @user.name = "a" * 244 + "@gmail.com"
    assert_not @user.valid?
  end

  test "email validation should accept a valid addresses" do
    valid_addresses = %w[user@exemple.com USER@foo.COM A_US_ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_addresses
      assert_not @user.valid? "#{valid_address.inspect} should be valid"
    end
  end

  test "email address should reject invalid address" do
    invalid_addresses = %w[user@exemple,com user_at_foo.org user.name@exemple.
                          foo@baz_baz.com foo@baz+bar.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid? "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present {non blank}" do
    blank_password = " " * 6
    @user.password_digest = blank_password
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    to_little_password = "a" * 5
    @user.password = @user.password_confirmation = to_little_password
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember,'')
  end

  test " associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "something")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    matei = users(:matei)
    gigi = users(:gigi)
    assert_not matei.following?(gigi)
    matei.follow(gigi)
    assert matei.following?(gigi)
    assert gigi.followers.include?(matei)
    matei.unfollow(gigi)
    assert_not matei.following?(gigi)
  end

  test"feed should have the right posts" do
    matei= users(:matei)
    gigi = users(:gigi)
    lana= users(:lana)
    #Post from followed user
    lana.microposts.each do |post_following|
      assert matei.feed.include?(post_following)
    end

    #Post from self
    matei.microposts.each do |post_self|
      assert matei.feed.include?(post_self)
    end
    #Post from unfollowed user
    gigi.microposts.each do |post_unfollowed|
      assert_not matei.feed.include?(post_unfollowed)
    end
  end
end
