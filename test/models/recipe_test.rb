require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname:"Anuja", email:"anuja@example.com")
    @recipe =@chef.recipes.build(name: "Vegetable",description: "Great vegetable recipe")
  end
  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end
  test "name should be present" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  test "description should be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  test "description shouldn't be min than 5 chars" do
    @recipe.description = "a" * 3
  end
  test "description shouldn't be more than 500 chars" do
    @recipe.description = "a" * 501
  end

end