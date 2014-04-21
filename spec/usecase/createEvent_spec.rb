require_relative '../spec_helper.rb'

describe Timeline::CreateEvent do
  before do

    @db = Timeline.db
    @db.clear_everything


    %w{Alice Bob}.each {|name| @db.create_user :name => name }
    %w{Students Teachers}.each {|name| @db.create_team :name => name }

    @alice = @db.all_users.find {|user| user.name == 'Alice' }
    @students = @db.all_teams.find {|team| team.name == 'Students' }
    @teachers = @db.all_teams.find {|team| team.name == 'Teachers' }

  end

  it "should creates an event" do
    event = @db.create_event :user_id => @alice, :name => 'Ping', :team_id => @students.id
    expect(event).to be_a Timeline::Event
    expect(event.name).to eq 'Ping'
    expect(event.id).to_not be_nil
    expect(event.created_at).to be_a Time

    result = subject.run :name => 'Ping', :team_id => @students.id
    expect(result.error).to eq :that_user_does_not_exist
    expect(@alice.name).to eq "Alice"

    result = subject.run :name => 'Ping', :team_id => @students.id, :user_id => @alice.id

    expect(result.event.name).to eq 'Ping'
    expect(result.success?).to eq true

  end


end
