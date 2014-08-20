class AddDegreeRequirementColumnToCourses < ActiveRecord::Migration
  def up
    add_column :courses, :degree_requirement, :integer, null: false
  end
  def down
    remove_column :courses, :degree_requirement
  end
end
