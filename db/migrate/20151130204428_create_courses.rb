class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :privacy , null: false
      t.text :tags, null: false
      t.text :objectives, null: false
      t.belongs_to :owner
      t.timestamps null: false
    end
  end
end
