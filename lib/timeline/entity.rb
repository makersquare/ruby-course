module Timeline
  def self.seed_db
    @db = Timeline.db
    user = @db.create_user(:name => "parth")
    team = @db.create_team(:name => "wizards")
    team2 = @db.create_team(:name => "makersquares")
    event = @db.create_event(:user_id => user.id, :team_id => team.id, :name => "event", :content => "this is great", :tags => ['a', 'b'] )
  end

  def self.db
   if @database_type == "persistence"
      @db = Database::SQLiteDatabase.new
    else
      @db ||= Database::InMemory.new
    end
  end

  def self.setter(database_type)
    @database_type = database_type
  end

  class Entity
    include ActiveModel::Validations

    def initialize(attrs=nil)
      attrs && attrs.each do |attr, value|
        setter = "#{attr}="
        self.send(setter, value) if self.class.method_defined?(setter)
      end
    end
  end
end
