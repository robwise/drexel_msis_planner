class AddCorequisiteToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :corequisite, :string, null: false
  end
end
