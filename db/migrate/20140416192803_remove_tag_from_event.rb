class RemoveTagFromEvent < ActiveRecord::Migration

  def change
    remove_column :events, :tags, :string
  end
end
