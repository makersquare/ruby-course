class Tags < ActiveRecord::Migration
  def change
    # TODO
    create_table :tags do |t|
      t.references :events
      t.string :content

    end
  end
end
