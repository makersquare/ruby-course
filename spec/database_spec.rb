require 'spec_helper'
require 'pry-debugger'
require 'date'

describe MyApp::DB do
  it "does stuff" do
    # DONT DO THIS (bad)
    # MyApp.db.create_project(...)

    # DO THIS (good)
    # db = MyApp::DB.new
    # db.create_project(...)
  end
end
