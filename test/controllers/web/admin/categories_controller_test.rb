require "test_helper"

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:one)
    sign_in(@admin)
  end

  test "should get index" do
    get admin_categories_path
    assert_response :success
  end

  test "should get new" do
    get new_admin_category_path
    assert_response :success
  end

  test "should create category" do
    attrs = {
      name: Faker::Science.element
    }

    assert_difference("Category.count") do
      post admin_categories_url, params: { category: attrs }
    end

    created_category = Category.find_by(attrs)

    assert created_category
    assert_redirected_to admin_categories_path
  end

  test "shhould not create category if user is not an admin" do
    sign_in(@user)

    attrs = {
      name: Faker::Science.element
    }

    post admin_categories_url, params: { category: attrs }

    assert_redirected_to root_path
  end
end
