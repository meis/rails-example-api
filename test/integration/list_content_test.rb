require 'test_helper'

class ListContentTest < ActionDispatch::IntegrationTest
  test "return all content" do
    get "/content"
    assert_response :success

    response = JSON.parse @response.body

    size = response["size"]
    items = response["items"]

    assert_equal 6, size

    # Sort by create date
    assert_equal "Third movie", items[0]["title"]
    assert_equal "Second movie", items[1]["title"]
    assert_equal "Third season", items[2]["title"]
    assert_equal "First movie", items[3]["title"]
    assert_equal "Second season", items[4]["title"]
    assert_equal "First season", items[5]["title"]

    # Include purchase options
    assert_equal "SD", items[3]["purchaseOptions"][0]["quality"]
    assert_equal "SD", items[5]["purchaseOptions"][0]["quality"]
    assert_equal "HD", items[5]["purchaseOptions"][1]["quality"]
  end

  test "return only movies" do
    get "/content?type=movie"
    assert_response :success

    response = JSON.parse @response.body

    size = response["size"]
    items = response["items"]

    assert_equal 3, size

    # Sort by create date
    assert_equal "Third movie", items[0]["title"]
    assert_equal "Second movie", items[1]["title"]
    assert_equal "First movie", items[2]["title"]

    # Include purchase options
    assert_equal "SD", items[2]["purchaseOptions"][0]["quality"]
  end

  test "return only seasons" do
    get "/content?type=season"
    assert_response :success

    response = JSON.parse @response.body

    size = response["size"]
    items = response["items"]

    assert_equal 3, size

    # Sort by create date
    assert_equal "Third season", items[0]["title"]
    assert_equal "Second season", items[1]["title"]
    assert_equal "First season", items[2]["title"]

    # Include episodes
    episodes = items[2]["episodes"]
    assert_equal 3, episodes.size
    assert_equal "First", episodes[0]["title"]
    assert_equal "Second", episodes[1]["title"]
    assert_equal "Third", episodes[2]["title"]

    # Include purchase options
    assert_equal "SD", items[2]["purchaseOptions"][0]["quality"]
    assert_equal "HD", items[2]["purchaseOptions"][1]["quality"]
  end


  test "return unexistent type of content" do
    get "/content?type=test"
    assert_response :success

    response = JSON.parse @response.body

    size = response["size"]
    items = response["items"]

    assert_equal 0, size
    assert_equal 0, items.size
  end
end
