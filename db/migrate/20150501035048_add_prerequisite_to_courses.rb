class AddPrerequisiteToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :prerequisite, :string
  end
end
