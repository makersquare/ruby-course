class AddEventIdToTags < ActiveRecord::Migration
  def change
    # TODO
    add_column(:tags, :event_id, :integer, references: :events)
    add_index :tags, :event_id
  end
end
