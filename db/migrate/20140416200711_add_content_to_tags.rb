class AddContentToTags < ActiveRecord::Migration
  def change
    # TODO
    add_column :tags, :content, :string
  end
end
