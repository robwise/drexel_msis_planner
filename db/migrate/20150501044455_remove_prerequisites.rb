class RemovePrerequisites < ActiveRecord::Migration
  def change
    drop_table :prerequisites
  end
end
