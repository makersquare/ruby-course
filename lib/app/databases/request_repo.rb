require 'pg'
module PAWS
  module Repos
    class RequestRepo

      def initialize
        @db = PG.connect(host:'localhost',dbname:'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text
            )
          ])
      end
#     price_id money REFERENCES price_list ( id )

      def log
        result = @db.exec('SELECT * FROM requests;')
        build_request(result.entries)
      end

      def add_request(request)
        pups_available = PAWS::Repos::PuppyRepo.new.log.select {|p| p.breed == request.breed }
        if pups_available.empty?
          request.on_hold!
        end

        result = @db.exec(%q[
          INSERT INTO requests (breed,status) 
          VALUES ($1, $2)
          RETURNING id;
        ], [request.breed,request.status])
        request.id = result.entries.first["id"].to_i

        # price_id ?
      end

      def update_request_status(request)
        @db.exec(%q[
          UPDATE requests
          SET status = $1
          WHERE id = $2;
        ], [request.status,request.id])
      end

      def update_request_status_by_db_id(status,id)
        @db.exec(%q[
          UPDATE requests
          SET status = $1
          WHERE id = $2;
        ], [status,id])
      end

      def show_pending_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'pending';
          ])
        build_request(result.entries)
      end

      def show_completed_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'complete';
          ])
        build_request(result.entries)
      end

      def show_on_hold_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'on_hold';
          ])
        build_request(result.entries)
      end

      def build_request(entries)
        entries.map do |req_hash|
          x = PAWS::Request.new(req_hash["breed"], req_hash["status"].to_sym, req_hash["id"].to_i)
          x
        end
      end

      def drop_table
        @db.exec(%q[
          DROP TABLE requests
          ])
      end

    end
  end
end
