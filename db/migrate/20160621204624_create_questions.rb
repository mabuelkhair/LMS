class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :quiz_id
      t.text :question
      t.integer :number_of_options
      t.float :weight,:default => 1.0
      t.string :answer1
      t.string :answer2
      t.string :answer3
      t.string :answer4
      t.string :answer5
      t.string :answer6
      t.string :answer7
      t.string :answer8

      t.timestamps null: false
    end
  end
end
