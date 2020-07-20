require 'test_helper'

class PurchaseOptionTest < ActiveSupport::TestCase
  test "belongs to Content" do
    option = PurchaseOption.new(quality: :HD, price: 2)

    assert_raises(ActiveRecord::RecordInvalid) do
      option.save!
    end

    option.content = content(:season2)
    option.save!
  end

  test "Only has HD or SD qualities" do
    assert_raises(ArgumentError) do
      PurchaseOption.create!(quality: :UHD, price: 10, content: content(:season2))
    end
  end

  test "can't duplicate quality inside Content" do
    s02_hd = PurchaseOption.create!(quality: :HD, price: 10, content: content(:season2))
    s03_hd = PurchaseOption.create!(quality: :HD, price: 10, content: content(:season3))

    s02_sd = PurchaseOption.new(quality: :HD, price: 10, content: content(:season2))
    assert_raises(ActiveRecord::RecordInvalid) do
      s02_sd.save!
    end

    s02_sd.quality = 'SD'
    s02_sd.save!
  end
end
