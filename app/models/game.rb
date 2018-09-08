class Game < ActiveRecord::Base
     MINIMUM_ADVANTAGE   = 2
     POINTS_TO_WIN       = 21 
 
     belongs_to :user, class_name: 'User'
     belongs_to :opponent, class_name: 'User'

     after_save :update_score_participating_players
     
     validates :user_id, :opponent_id, presence: true
     validate :correct_score?
 
     def correct_score?
         begin
             advantage_game = 0
             if user_score >= POINTS_TO_WIN && user_score > opponent_score
                 advantage_game = user_score - opponent_score
             elsif opponent_score >= POINTS_TO_WIN && opponent_score > user_score
                 advantage_game = opponent_score - user_score
             end
             return true if advantage_game >= MINIMUM_ADVANTAGE
             errors.add(:base, "The minimum advantage is 2 points and the game is won to 21 points")
             return false
         rescue
             # user_score or opponent_score Nil
             errors.add(:base, "The minimum advantage is 2 points and the game is won to 21 points")
             return false
         end
     end

=begin
- Cuando el ganador tiene un puntaje igual o mayor al perdedor:
	Puntaje del ganador aumenta 4 puntos y el del perdedor resta -2

- Cuando el ganador tiene un puntaje menor al perdedor :
	Puntaje del ganador aumenta 6 puntos y el del perdedor resta -3
=end
     def update_score_participating_players

          winner_player  = (user_score > opponent_score) ? User.find(user_id) : User.find(opponent_id)
          loser_player   = (user_score < opponent_score) ? User.find(user_id) : User.find(opponent_id)
          
          if winner_player.historical_score >= loser_player.historical_score
               winner_player.update_column(:historical_score, (winner_player.historical_score + 4))
               loser_player.update_column(:historical_score, (loser_player.historical_score - 2))
          elsif winner_player.historical_score < loser_player.historical_score
               winner_player.update_column(:historical_score, (winner_player.historical_score + 6))
               loser_player.update_column(:historical_score, (loser_player.historical_score - 2))
          end

          # Update count games to participating players
          winner_player.update_column(:count_games, (winner_player.count_games +=1))
          loser_player.update_column(:count_games, (loser_player.count_games +=1))
     end
     
 end
 