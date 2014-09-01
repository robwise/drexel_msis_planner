class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :user_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :plans, :user_id
  end
end
