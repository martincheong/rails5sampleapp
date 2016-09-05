require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                  password:"foobar", password_confirmation: "foobar")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  #testing validations
  test "user name should be present" do
    #set name to blank
    @user.name ="   "
    assert_not @user.valid?
  end

  test "user email should be present" do
    #set email to blank
    @user.email = "     "
    assert_not @user.valid?
  end

  test "user name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "user email should not be too long" do
    @user.email = "a"*244 + "@example.com"
    assert_not @user.valid?
  end

  test "user email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com User@fo.COM A_Ue-3@foo.bar.org
                    first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end

  end

  test "user email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "user email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "user email addresses are saved as downcase" do
    email_upcase = "EXAMPLE@EXAMPLE.COM"
    @user.email = email_upcase
    @user.save
    assert_equal email_upcase.downcase, @user.reload.email
  end

  test "user password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "user password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "user password_confirmation needs to be filled" do
    @user.password = "testpassword"
    @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "user password_confirmation needs to be matching" do
    @user.password = "testpassword"
    @user.password_confirmation = "wrongpassword"
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember,"")
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    railstutorial = users(:railstutorial)
    archer = users(:archer)
    assert_not railstutorial.following?(archer)
    railstutorial.follow(archer)
    assert railstutorial.following?(archer)
    assert archer.followers.include?(railstutorial)
    railstutorial.unfollow(archer)
    assert_not railstutorial.following?(archer)

  end
end
