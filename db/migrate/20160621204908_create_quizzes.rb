class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :course_id
      t.string :name
      t.timestamps null: false
    end
  end
end
