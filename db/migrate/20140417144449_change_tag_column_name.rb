class ChangeTagColumnName < ActiveRecord::Migration
  def change
    rename_column :tags, :events_id, :event_id
  end
end
