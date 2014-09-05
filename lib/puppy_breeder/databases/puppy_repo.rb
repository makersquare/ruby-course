require 'pg'
require 'pry-byebug'

module PuppyBreeder
  module Repos
    class PuppyRepo

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies (
            id serial,
            name text,
            breed text,
            age int,
            adoption_status text
            )
          ])
      end

      def drop_and_rebuild
        @db.exec(%q[
            DROP TABLE puppies;
          ])
        build_tables
      end

      def add_puppy(pup)
      
        result = @db.exec(%q[
            INSERT INTO puppies (name, breed, age, adoption_status)
            VALUES ($1, $2, $3, $4)
            RETURNING id;
            ], [pup.name, pup.breed, pup.age, pup.adoption_status])
      end

      def puppies

        result = @db.exec('SELECT * FROM puppies;')
        build_request(result.entries)
      end

      def build_request(entries)
        entries.map do |pup|
          x = PuppyBreeder::Puppy.new(pup['name'], pup['breed'], pup['age'].to_i, pup['adoption_status'].to_sym)
          x.instance_variable_set :@id, pup['id'].to_i
          x
        end
      end

    end
  end
end

