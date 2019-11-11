require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get grid" do
    get game_grid_url
    assert_response :success
  end

  test "should get results" do
    get game_results_url
    assert_response :success
  end

end
