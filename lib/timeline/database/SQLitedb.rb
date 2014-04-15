class SQLiteDatabase

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'myapp-test.db'
    )
  end

  # Define models and relationships here (yes, classes within a class)
  class User < ActiveRecord::Base
    belongs_to :team
  end

  class Team < ActiveRecord::Base
    has_many :user
  end

  class Event <ActiveRecord::Base
    has_many :teams
  end

  # Now implement you database methods here

  def create_user(attrs)
    # NOTE the difference betwee the two `User` classes.
    # The first inherits from ActiveRecord, while
    # the second is your app's entity class
    ar_user = User.create(attrs)
    MyApp::User.new(ar_user.attributes)
  end

end
