require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:malory)
    @admin = users(:railstutorial)
    @other_user = users(:archer)
    @non_admin = users(:lana)
  end

  test "should redirect index when not logged in" do
      get users_path
      assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              "",
                                            password_confirmation: "",
                                            admin: true } }
    # reload @other_user after attempting to patch
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when not logged in" do
      assert_no_difference 'User.count' do
        delete user_path(@admin)
      end
      assert_redirected_to login_url
    end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@admin)
    end
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
