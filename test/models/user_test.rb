require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "requires unique email" do
    user = User.new()
    assert_raises(ActiveRecord::NotNullViolation) do
      user.save!
    end

    user.email = users(:one).email
    assert_raises(ActiveRecord::RecordInvalid) do
      user.save!
    end

    user.email = "three@users.com"
    user.save!
  end
end
