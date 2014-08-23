class CreateEnrolledIns < ActiveRecord::Migration
  def up
    create_table :enrolled_ins do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false
      t.integer :grade, null: false
      t.integer :quarter, null: false

      t.timestamps
    end

    add_index :enrolled_ins, [:user_id, :course_id]
  end

  def down
    drop_table :enrolled_ins
  end
end
