class AddScoreColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer, default: 20
  end
end
