require 'spec_helper'

describe 'Honkr#db' do
  it "is a singleton" do
    db1 = Honkr.db
    db2 = Honkr.db
    expect(db1).to be(db2)
  end
end
