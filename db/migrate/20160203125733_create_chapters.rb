class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.text :description
      t.belongs_to :course
      t.timestamps null: false
    end
  end
end
