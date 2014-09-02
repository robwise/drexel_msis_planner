class CreatePlannedCourses < ActiveRecord::Migration
  def change
    create_table :planned_courses do |t|
      t.integer :plan_id, null: false
      t.integer :course_id, null: false
      t.integer :quarter

      t.timestamps
    end
  end
end
