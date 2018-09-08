class AddPlayersToGames < ActiveRecord::Migration
  def change
    add_reference :games, :user, index: true, foreign_key: true
    add_reference :games, :opponent, index: true, foreign_key: true
  end
end
