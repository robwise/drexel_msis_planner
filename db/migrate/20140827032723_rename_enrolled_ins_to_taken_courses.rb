class RenameEnrolledInsToTakenCourses < ActiveRecord::Migration
  def up
    rename_table :enrolled_ins, :taken_courses
  end
  def down
    rename_table :taken_courses, :enrolled_ins
  end
end
