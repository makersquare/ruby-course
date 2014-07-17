class CreateTags < ActiveRecord::Migration
  def change
    # TODO
    create_table :tags do |t|
    	t.references :event
    end
  end
end
