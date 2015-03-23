class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.integer :requiring_course_id, index: true, required: true
      t.string :raw_text, required: true

      t.timestamps null: false
    end
    add_foreign_key :prerequisites, :courses, column: :requiring_course_id
  end
end
