require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:railstutorial)
    @non_admin = users(:archer)
  end

  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
      #unless the user display is admin, *cannot delete self*
      #should have delete text next to them
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index unactivated user will not be displayed" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user:{name:"Example User",
                                      email: "user@example.com",
                                      password:             "password",
                                      password_confirmation:"password"}}
    end
    user = assigns(:user)
    get user_path(user)
    #unactivated user should be redirect to root
    follow_redirect!
    assert_template 'static_pages/home'
  end
end
