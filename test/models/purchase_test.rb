require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  test "required fields" do
    purchase = Purchase.new();

    assert_raises(ActiveRecord::RecordInvalid) do
      purchase.save!
    end

    purchase.user = users(:one)
    assert_raises(ActiveRecord::RecordInvalid) do
      purchase.save!
    end

    purchase.purchase_option = purchase_options(:season1_hd)
    purchase.save!
  end

  test "sets a default expiry_date" do
    purchase = Purchase.new(
      user: users(:one),
      purchase_option: purchase_options(:season1_hd),
    )
    purchase.save!

    assert_equal (purchase.created_at + 2.days).iso8601(0), purchase.expiry_date.iso8601(0)
  end

  test "only one purchase active" do
    Purchase.create!(
      user: users(:one),
      purchase_option: purchase_options(:season1_hd),
    )

    assert_raises(ActiveRecord::RecordInvalid) do
      Purchase.create!(
        user: users(:one),
        purchase_option: purchase_options(:season1_hd),
      )
    end

    travel_to DateTime.now + 3.day do
      Purchase.create!(
        user: users(:one),
        purchase_option: purchase_options(:season1_hd),
      )
    end
  end

  test "scope active" do
    @now = DateTime.now
    @user = users(:one)

    travel_to @now - 1.year do
      Purchase.create!(
        user: @user,
        purchase_option: purchase_options(:season1_hd),
      )
    end

    travel_to @now - 1.day do
      Purchase.create!(
        user: @user,
        purchase_option: purchase_options(:season1_hd),
      )
    end

    travel_to @now do
      Purchase.create!(
        user: @user,
        purchase_option: purchase_options(:season1_sd),
      )
    end

    assert_equal 2, Purchase.active.count

    travel_to @now + 1.day + 1.minute do
      assert_equal 1, Purchase.active.count
    end
  end

end
