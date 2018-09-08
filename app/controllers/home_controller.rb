class HomeController < ApplicationController
  def index
    @users = User.all.order(historical_score: :desc)
  end
end
