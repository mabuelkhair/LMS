class ChangeProfileInfoDefaultValuesToUser < ActiveRecord::Migration
  def change
  	change_column :users, :birthdate, :date, :default => "2015-01-01"
  	change_column :users, :jobtitle, :string, :default => "N/A"
  	change_column :users, :gender, :string, :default => "N/A"
  	change_column :users, :address, :string, :default => "N/A"
  	change_column :users, :bio, :string, :default => "N/A"
  end
end
