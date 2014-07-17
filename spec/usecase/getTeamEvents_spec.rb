require_relative '../spec_helper.rb'

describe Timeline::GetTeamEvents do
  before do
    @db = Timeline.db
    @db.clear_everything


    %w{Alice Bob}.each {|name| @db.create_user :name => name }
    %w{Students Teachers}.each {|name| @db.create_team :name => name }

    @alice = @db.all_users.find {|user| user.name == 'Alice' }
    @students = @db.all_teams.find {|team| team.name == 'Students' }
    @teachers = @db.all_teams.find {|team| team.name == 'Teachers' }

  end

  it "should get all the Events for a Team" do
    # Create event now
    @db.create_event :name => 'x', :team_id => @students.id

    event = @db.get_events_by_team(@students.id)
    expect(event.count).to eq 1
    expect(event.map &:name).to eq ['x']

    result = subject.run :team_id => @students.id

    # puts @students.id
    # puts result
    # expect(result.events.name).to eq 'x'

    expect(result.events.first.id).to eq event.first.id
    expect(result.events.count).to eq 1
    expect(result.success?).to eq true


  end



end
