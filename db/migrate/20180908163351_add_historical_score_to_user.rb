class AddHistoricalScoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :historical_score, :integer, default: 0
  end
end
