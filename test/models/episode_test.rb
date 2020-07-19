require 'test_helper'

class EpisodeTest < ActiveSupport::TestCase
  test "belongs to a content" do
    episode = Episode.new(title: 'Three', plot: 'Plot', number: 3)

    assert_raises(ActiveRecord::RecordInvalid) do
      episode.save!
    end

    episode.content = content(:season2)
    episode.save!
  end

  test "can't duplicate number inside Seasons" do
    s02e04 = Episode.new(title: 'Last', plot: 'Plot', number: 4, content: content(:season2))
    s03e04 = Episode.new(title: 'Last', plot: 'Plot', number: 4, content: content(:season3))
    
    s02e04.save!
    s03e04.save!
    
    s03e05 = Episode.new(title: 'Last Last', plot: 'Plot', number: 4, content: content(:season3))
    assert_raises(ActiveRecord::RecordInvalid) do
      s03e05.save!
    end

    s03e05.number = 5
    s03e05.save!
  end
end
