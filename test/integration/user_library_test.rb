require 'test_helper'

class UserLibraryTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @purchase_option = purchase_options(:movie1_sd)
    
    Purchase.destroy_all
  end

  test "list purchased content requires a user" do
    get "/purchase"
    assert_response :unauthorized
  end

  test "list purchased content show current purchases" do
    get "/purchase", params: { user_id: @user.id }
    assert_response :success
    response = JSON.parse @response.body
    assert_equal 0, response["size"]
    assert_equal 0, response["items"].size

    purchase = Purchase.create!( user: @user, purchase_option: @purchase_option )

    get "/purchase", params: { user_id: @user.id }
    assert_response :success
    response = JSON.parse @response.body
    assert_equal 1, response["size"]
    assert_equal 1, response["items"].size

    item = response["items"].first
    content = @purchase_option.content
    assert_equal purchase.expiry_date.as_json, item["expiryDate"]
    assert_equal @purchase_option.quality, item["quality"]
    assert_equal content.id, item["content"]["id"]
  end

  test "list purchased content don't show expired purchases" do
    get "/purchase", params: { user_id: @user.id }
    assert_response :success
    response = JSON.parse @response.body
    assert_equal 0, response["size"]

    Purchase.create!( user: @user, purchase_option: @purchase_option )

    travel_to DateTime.now + 2.day + 1.minute do
      get "/purchase", params: { user_id: @user.id }
      assert_response :success
      response = JSON.parse @response.body
      assert_equal 0, response["size"]
    end
  end
end
