# coding: utf-8
require 'test_helper'

class Admin::TopControllerTest < ActionController::TestCase
  test "index for a common member" do
    login_as("taro")
    get :index
    assert_response 403
  end

  test "index for an admin" do
    login_as("jiro", true)
    get :index
    assert_response :success
  end
end
