require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  test "return movies and seasons" do
    contents = Content.all

    assert_equal 6, contents.count
  end

  test "required attributes" do
    assert_raises(ActiveRecord::RecordInvalid) do
      Content.create!
    end

    assert_raises(ActiveRecord::RecordInvalid) do
      Content.create!(title: 'title')
    end

    assert_raises(ActiveRecord::RecordInvalid) do
      Content.create!(title: 'title', plot: 'plot')
    end

    assert_raises(ArgumentError) do
      Content.create!(title: 'title', plot: 'plot', content_type: :test)
    end

    Content.create!(title: 'title', plot: 'plot', content_type: :movie)
    Content.create!(title: 'title', plot: 'plot', content_type: :season)
  end
end
