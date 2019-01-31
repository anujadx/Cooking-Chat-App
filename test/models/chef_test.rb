require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "Anuja", email: "anujadeshan@yahoo.com")
  end
  test " should be vaild" do
    assert @chef.valid?
  end
  test "name should be valid" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  test "name shouldn't be min than 30 chars" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  test "email should be valid" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  test "email shouldn't be min than 255 chars" do
    @chef.chefname = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end
  test "email address should be invaild format" do
    valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  test "should reject invalid addresses" do
    invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail.com, joe@bar+foo.com]
    invalid_emails.each do |invailds|
      @chef.email = invailds
      assert_not @chef.valid?, "#{invailds.inspect} should be invalid"
    end
  end
  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  test "email should be lowercase before hitting the database" do
    mixed_email = "JohN@ExampLe.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
end