class AddNotNullConstraintToPlannedCourse < ActiveRecord::Migration
  def change
    change_column_null :planned_courses, :quarter, false
  end
end
