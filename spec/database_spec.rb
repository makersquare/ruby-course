require 'spec_helper'

describe 'Honker#db' do
  it "is a singleton" do
    db1 = Honker.db
    db2 = Honker.db
    expect(db1).to be(db2)
  end
end
