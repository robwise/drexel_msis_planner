class AddIndexToCourses < ActiveRecord::Migration
  def up
    add_index :courses, [:department, :level]
  end

  def down
    remove_index :courses, [:department, :level]
  end
end
