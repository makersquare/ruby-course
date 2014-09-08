module Songify
  module Repos
    class Songs

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
      end
      
    end
  end
end