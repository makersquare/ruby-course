module Timeline
  module Database

    # def self.db
    #   @__db_instance ||= DB.new(@app_db_name)
    # end

    # def self.db_name=(db_name)
    #   @app_db_name = db_name
    # end

    class SQLiteDatabase

      def initialize
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => 'db-test.db'
        )
      end

      # Define models and relationships here (yes, classes within a class)
      class User < ActiveRecord::Base
        has_many :events
      end

      class Team < ActiveRecord::Base
        has_many :events
      end

      class Events < ActiveRecord::Base
        belongs_to :user, :team
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
  end
end
