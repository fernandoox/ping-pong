class AddCountGamesToUser < ActiveRecord::Migration
  def change
    add_column :users, :count_games, :integer, default: 0
  end
end
