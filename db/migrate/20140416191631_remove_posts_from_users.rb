class RemovePostsFromUsers < ActiveRecord::Migration
  def change
    # TODO
    remove_column :users, :posts
  end
end
