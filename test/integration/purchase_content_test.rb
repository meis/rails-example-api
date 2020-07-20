require 'test_helper'

class PurchaseContentTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @purchase_option = purchase_options(:movie1_sd)

    Purchase.destroy_all
  end

  test "purchase content requires user_id, content_id and quality" do
    post "/purchase"
    assert_response :unauthorized
    purchase = Purchase.take()
    assert_nil purchase

    post "/purchase", params: { user_id: @user.id }
    assert_response :not_found
    purchase = Purchase.take()
    assert_nil purchase

    post "/purchase", params: { user_id: @user.id, content_id: @purchase_option.content.id }
    assert_response :not_found  
    purchase = Purchase.take()
    assert_nil purchase 

    post "/purchase", params: { user_id: @user.id, content_id: @purchase_option.content.id, quality: @purchase_option.quality }
    assert_response :success   
  end

  test "purchase content allow a user to purchase a product" do
    assert_equal 0, Purchase.active.where(user: @user).count

    post "/purchase", params: { user_id: @user.id, content_id: @purchase_option.content.id, quality: @purchase_option.quality }
    assert_response :success
    assert_equal 1, Purchase.active.where(user: @user).count

    purchase = Purchase.take()
    assert_equal purchase.user, @user
    assert_equal purchase.purchase_option, @purchase_option 
  end

  test "purchase content don't allow duplicated active purchases" do
    assert_equal 0, Purchase.active.where(user: @user).count

    post "/purchase", params: { user_id: @user.id, content_id: @purchase_option.content.id, quality: @purchase_option.quality }
    assert_response :success
    assert_equal 1, Purchase.active.where(user: @user).count
    
    post "/purchase", params: { user_id: @user.id, content_id: @purchase_option.content.id, quality: @purchase_option.quality }
    assert_response :forbidden
    assert_equal 1, Purchase.active.where(user: @user).count
  end

  test "purchase content allow non-active duplicates" do
    post "/purchase", params: { user_id: @user.id, content_id: @purchase_option.content.id, quality: @purchase_option.quality }
    assert_response :success

    travel_to DateTime.now + 2.day + 1.minute do
      post "/purchase", params: { user_id: @user.id, content_id: @purchase_option.content.id, quality: @purchase_option.quality }
      assert_response :success
    end
  end
end
