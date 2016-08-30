require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    # two links point to root_path, Logo and Home(navbar right)
    assert_select "a[href=?]", root_path, count: 2
    # 1 help link on navbar-right
    assert_select "a[href=?]", help_path
    # 1 about link on footer
    assert_select "a[href=?]", about_path
    # 1 contact link on footer
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select 'title', full_title("Contact")
  end

  test "sign up page" do
    get signup_path
    assert_template 'users/new'
    assert_equal full_title("Sign Up"), "Sign Up | Ruby on Rails Tutorial Sample App"
  end
end
