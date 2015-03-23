class AddRawTextToPrerequisites < ActiveRecord::Migration
  def change
    add_column :prerequisites, :raw_text, :string, null: false
  end
end
