require 'pg'
module PAWS
  module Repos
    class PuppyRepo

      def initialize
        @db = PG.connect(host:'localhost',dbname:'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies(
            id serial,
            breed text,
            name text,
            age_in_days int,
            status text
            )
          ])
      end

      def log
        result = @db.exec('SELECT * FROM puppies;')
        build_puppies(result.entries)
      end

      def build_puppies(entries)
        entries.map do |pup_hash|
          x = PAWS::Puppy.new(pup_hash["breed"], pup_hash["name"], pup_hash["age_in_days"].to_i, pup_hash["status"])
          x.instance_variable_set :@id, pup_hash["id"].to_i
          x
        end
      end

      def add_puppy(puppy)  
        open_requests = PAWS.request_repo.log.select { |p| p.breed == puppy.breed && p.on_hold? }
        on_hold_request = open_requests.find {|p| p.on_hold?}
        if on_hold_request
          match_puppy(puppy,on_hold_request)
        end

        result = @db.exec(%q[
          INSERT INTO puppies (breed,name,age_in_days,status)
          VALUES ($1, $2, $3, $4)
          RETURNING id;
        ], [puppy.breed,puppy.name,puppy.age_in_days,puppy.status])
        puppy.id = result.entries.first["id"].to_i
      end

      def match_puppy(puppy,status_matching_po)
        puppy.adopted!
        status_matching_po.complete!
        PAWS.request_repo.update_request_status(status_matching_po)
      end

      def show_all_breeds
        result = @db.exec(%q[
          SELECT breed FROM puppies;
          ])
        result.entries.collect {|x| x["breed"]}
      end

      def show_available_breeds
        result = @db.exec(%q[
          SELECT breed FROM puppies WHERE status = 'available';
          ])
        answer = result.entries.collect {|x| x["breed"]}
      end

      def show_all_available_puppies
        result = @db.exec(%q[
          SELECT * FROM puppies WHERE status = 'available';
          ])
        build_puppies(result.entries)
      end

      def show_all_adopted_puppies
        result = @db.exec(%q[
          SELECT * FROM puppies WHERE status = 'adopted';
          ])
        build_puppies(result.entries)
      end

      def adoptathon
        pending_requests = PAWS.request_repo.log.select { |p| p.pending?}
        pending_requests.each do |pending_request|
          available_puppies = show_all_available_puppies
          puppy_to_adopt = available_puppies.find { |puppy| pending_request.breed == puppy.breed }
          if puppy_to_adopt
            match_puppy(puppy_to_adopt,pending_request)
            update_puppy_status(puppy_to_adopt)
          end
        end
      end

      def update_puppy_status(puppy_to_adopt)
        @db.exec(%q[
          UPDATE puppies
          SET status = $1
          WHERE id = $2;
        ], [puppy_to_adopt.status,puppy_to_adopt.id])
      end

      def update_puppy_status_by_db_id(status,id)
        @db.exec(%q[
          UPDATE puppies
          SET status = $1
          WHERE CONDITION id = $2;
        ], [status,id])
      end

      def drop_table
        @db.exec(%q[
          DROP TABLE puppies
          ])
      end

    end
  end
end
