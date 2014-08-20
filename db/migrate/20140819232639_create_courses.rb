class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :department
      t.integer :level
      t.string :title
      t.text :description

      t.timestamps
      add_index :department, :level
    end
  end
  def down
    drop_table :courses
  end
end
