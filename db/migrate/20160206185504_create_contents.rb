class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :name
      t.string :attachment
	  t.belongs_to :chapter
      t.timestamps null: false
    end
  end
end
