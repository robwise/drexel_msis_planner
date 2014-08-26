class AddUniquenessConstraintToEnrolledIns < ActiveRecord::Migration
  def up
    remove_index :enrolled_ins, [:user_id, :course_id]
    add_index :enrolled_ins, [:user_id, :course_id], unique: true
  end
  def down
    remove_index :enrolled_ins, [:user_id, :course_id]
    add_index :enrolled_ins, [:user_id, :course_id]
  end
end
