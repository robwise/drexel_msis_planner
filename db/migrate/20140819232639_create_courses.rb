class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :department, null: false
      t.integer :level, null: false
      t.string :title
      t.text :description

      t.timestamps
    end
  end
  def down
    drop_table :courses
  end
end
