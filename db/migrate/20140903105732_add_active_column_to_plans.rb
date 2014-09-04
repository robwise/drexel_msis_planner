class AddActiveColumnToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :active, :boolean, null: false
  end
end
