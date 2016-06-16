class CreateJoinRequests < ActiveRecord::Migration
  def change
    create_table :join_requests do |t|
      t.integer :course_id
      t.integer :requester_id

      t.timestamps null: false
    end
  end
end
