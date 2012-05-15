class AddEnabledToItems < ActiveRecord::Migration
  def change
    add_column :items, :enabled, :boolean, :default => true

  end
end
