class AddTimestampsAndContentAndName < ActiveRecord::Migration
  def change
    add_column(:events, :created_at, :datetime)
    add_column(:events, :name, :text)
    add_column(:events, :content, :text)
  end
end
