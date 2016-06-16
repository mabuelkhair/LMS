class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :attachment
      t.integer :course_id
      t.integer :assignment_id
      t.integer :student_id

      t.timestamps null: false
    end

    add_index :solutions, ["course_id","assignment_id","student_id"]
  end
end
