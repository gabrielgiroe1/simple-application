require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Simple App"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "about get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact page" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get routes" do
    get root_url
    assert_response :success
  end
end
