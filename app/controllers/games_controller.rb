class GamesController < ApplicationController
  before_action :get_opponentes, only: [:new, :create]
  def index
    @games = Game.where.not(opponent_id: current_user.id)
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.valid?
      @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  private
  def game_params
    params.require(:game).permit(:user_score, :opponent_score, :date_played, :user_id, :opponent_id)
  end

  private
  def get_opponentes
    @opponents = User.where.not(id: current_user.id)
  end

end