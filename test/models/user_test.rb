require 'test_helper'


class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
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
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  end
end

end
