require "test_helper"

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @bulletin = bulletins(:one)

    @bulletin.image.attach(file_fixture("cookie_fixture.jpg"))
    @bulletin.save!

    @category = categories(:one)
  end

  test "should get index" do
    get bulletins_url
    assert_response :success
  end

  test "should get new" do
    sign_in(@user)
    assert signed_in?

    get new_bulletin_path
    assert_response :success
  end

  test "should create bulletin" do
    upload_file_name = "cookie_fixture.jpg"

    attrs = {
      title: Faker::Science.element,
      description: Faker::Lorem.sentence(word_count: 10),
      image: fixture_file_upload(upload_file_name, "image/jpg"),
      category_id: @category.id
    }

    sign_in(@user)
    assert signed_in?

    assert_difference("Bulletin.count") do
        post bulletins_url, params: { bulletin: attrs }
    end

    created_bulletin = Bulletin.find_by(attrs.except(:image))
    uploaded_image = created_bulletin.image.filename

    assert created_bulletin
    assert created_bulletin.image.filename, upload_file_name
    assert_redirected_to root_path
  end

  test "should not create test if user is not logged in" do
    upload_file_name = "cookie_fixture.jpg"

    attrs = {
      title: Faker::Science.element,
      description: Faker::Lorem.sentence(word_count: 10),
      image: fixture_file_upload(upload_file_name, "image/jpg"),
      category_id: @category.id
    }

    post bulletins_url, params: { bulletin: attrs }

    assert_response :found
  end

  test "should show bulletin" do
    sign_in(@user)
    assert signed_in?

    get bulletin_path(@bulletin)
    assert_response :success
  end
end
