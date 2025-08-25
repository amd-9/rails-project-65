require "test_helper"

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:one)

    @bulletin = bulletins(:two)

    sign_in(@admin)
  end

  test "should get index" do
    get admin_bulletins_url
    assert_response :success
  end

  test "should get on_moderation" do
    get admin_bulletins_url
    assert_response :success
  end

  test "should redirect to root if use is not an admin" do
    sign_in(@user)

    get admin_bulletins_url
    assert_redirected_to root_path
  end

  test "should publish bulletin" do
    post change_state_bulletin_path(@bulletin, :archive)

    published_bulletin = Bulletin.find(@bulletin.id)

    assert published_bulletin.state, :published
  end
end
