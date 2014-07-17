class CreateEvents < ActiveRecord::Migration
  def change
    # TODO
    create_table :events do |t|
    	t.string :name
    	t.string :content
    	t.datetime :created_at
    	t.references :user
    	t.references :team
    end
  end
end
