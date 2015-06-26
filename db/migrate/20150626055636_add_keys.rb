class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "planned_courses", "courses", name: "planned_courses_course_id_fk"
    add_foreign_key "planned_courses", "plans", name: "planned_courses_plan_id_fk"
    add_foreign_key "plans", "users", name: "plans_user_id_fk"
    add_foreign_key "taken_courses", "courses", name: "taken_courses_course_id_fk"
    add_foreign_key "taken_courses", "users", name: "taken_courses_user_id_fk"
  end
end
