class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.text :description
      t.string :attachment
      t.date :due_date
      t.belongs_to :course
      t.timestamps null: false
    end
  end
end
