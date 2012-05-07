# coding: utf-8
require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test "index" do
    5.times { Factory(:article) }
    get :index
    assert_response :success
    assert_equal 5, assigns[:articles].count
  end

  test "show" do
    article = Factory(:article, expired_at: nil)
    get :show, id: article
    assert_response :success
  end
end
