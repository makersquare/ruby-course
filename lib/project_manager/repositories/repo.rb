require 'pg'

module PM
  module Repos
    def self.adapter=(dbname)
      @__db_conn = PG.connect(host: 'localhost', dbname: dbname)
    end

    def self.adapter
      @__db_conn
    end
  end
end
