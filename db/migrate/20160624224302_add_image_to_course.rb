class AddImageToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :avatar, :string
  end
end
