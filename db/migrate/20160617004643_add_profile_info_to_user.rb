class AddProfileInfoToUser < ActiveRecord::Migration
  def change
  	add_column :users, :birthdate, :date
  	add_column :users, :jobtitle, :string
  	add_column :users, :gender, :string
  	add_column :users, :address, :string
  	add_column :users, :bio, :string
  end
end
