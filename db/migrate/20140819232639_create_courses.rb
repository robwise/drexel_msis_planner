class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :department
      t.integer :level
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
