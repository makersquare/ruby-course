require 'spec_helper'

describe TM::CreateNewProj do

  it "creates a new project" do
    # Set up our data
    result = subject.run({:name => "Build Monuments to My Horse"})
    expect(result.success?).to eq true
    expect(result.project.name).to eq("Build Monuments to My Horse")
  end

end
