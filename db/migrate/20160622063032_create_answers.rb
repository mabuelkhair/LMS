class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :quiz_id
      t.float :grade
      t.float :total

      t.timestamps null: false
    end
  end
end
