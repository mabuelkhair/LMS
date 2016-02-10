class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.belongs_to :course
      t.timestamps null: false
    end
  end
end
