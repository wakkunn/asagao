# coding: utf-8

class TopController < ApplicationController
  def index
    @articles = Article.readable_for(@current_member).
                  order("released_at DESC").limit(5)
  end

  def about
  end

  def not_found
    raise ActionController::RoutingError,
      "No route matches #{request.path.inspect}"
  end
end
