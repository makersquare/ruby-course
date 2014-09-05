require 'pg'

module PuppyBreeder
  module Repos
  class RequestLog
      # @@request_log = []
      # @@hold_log = []
      #create a PG::Connection object and store it in
      #an instance variable called @db
      #run the build tables method
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables#()
      end
      #build tables takes the db connect object and runs
      #exec on it passing in a ruby multi line string
      #which tells the database to create a table called
      #requests if it doesn't exist with
      #an id field type serial (incrementing)
      #a breed field type text
      #status field type text
      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text 
            )
          ])# do we need a semi-colon?
      end

      def log
        #this code grabs all data from the database
        #called requests
        result = @db.exec('SELECT * FROM requests;') 
        #this code passes the .entries which is an array of
        #hashes where each hash is the field name and each
        #value is the value of the field. 
        #then it passes it to the method build_request
        build_request(result.entries)
      end

      #show requests method gets the pending status records
      def show_requests
        #on our @db variable which is pointing to the
        #connection we had made earlier to the database
        #and pulls all matching records that have status
        #pending as a PG::Result object
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'pending';
          ])
        #this takes the PG::Result object and changes the data
        #into an array of hashes where each hash is a record.
        #then it passes THAT array as an argument to the 
        #build request method which then returns a 
        #PuppyBreeder::PurchaseRequest object with the 
        #information from the table. 
        build_request(result.entries)
      end

      def show_accepted_requests

        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'accepted';
          ])
        build_request(result.entries)
      end

      #this method is
      def build_request(entries)
        #look at each of the hashes in the the array
        entries.map do |req|
          #a new purchase request is created with the req
          #representing the record in the table which is a hash
          #and the ["breed"] identifying the key (so this returns
            # the breed of that dog )
          x = PuppyBreeder::PurchaseRequest.new(req["breed"])
          #sets the value of the id for the request to the id
          #in the table and changes it to an integer
          x.instance_variable_set :@id, req["id"].to_i
          #sets the value of the x object status to what's in
          #the table status and converts it to a symbol because 
          #it was a symbol for nick but mine was a string. 
          x.instance_variable_set :@status, req["status"]
          #returns the new object called x which holds the record
          #that was just extracted from the table
          x
        end
      end
      #this should add the requests to the request_log
      #It looks at the puppy container and finds all
      #dogs that match the breed of the request breed
      #if there is no matching dog it will return an 
      #empty array
      def add_request(request)
        pups_available = PuppyBreeder::Repos::Puppy.log.select do |p|
          p.breed == request.breed
        end
        #if the array returned above is empty, then 
        #call the hold method on the request object that
        #was passed in to this method
        if pups_available.empty?
          request.hold!
        end

        #call the execute on the db connection object
        #and pass it a ruby string that adds to the request
        #table the breed and status from the passed in
        #object.
        @db.exec(%q[
          INSERT INTO requests (breed, status, id)
          VALUES ($1, $2);
          ] [request.breed, request.status, request.request_id])
      end
    end
  end
end

















#     def self.add_request(request)

#       if Inventory.puppies[request.breed] && Inventory.puppies[request.breed]["list"].length >= 1
#         @@request_log.push(request)
#     else
#       @@hold_log.push(request)
#     end
#   end

#     def self.review_pending
#       #prints out a list of the information regarding the request
#       pending = @@request_log.select{|request| request.status=="pending"}
#     end

#     def self.modify_request(request_id, decision) #takes the request id and 
#       #whether the request is approved or denied
#       found_request = @@request_log.select{|request| request.request_id == request_id}      
#       found_request.first.status = decision
#     end

#     def self.check_hold(puppy)
#       if @@hold_log.find{ |hold|  hold.breed == puppy.breed} #if the hold log includes the breed
#         #find the first purchase request and return it. 
#         hold = @@hold_log.find{ |hold|  hold.breed == puppy.breed}
#         @@request_log.push(hold)
#         @@hold_log.delete(hold)
#       end
#     end

#     def self.view_completed
#       completed_requests = @@request_log.select{|request| request.status !="pending"}
#     end

#     def self.request_log
#       @@request_log
#     end
#     def self.hold_log
#       @@hold_log
#     end
#   end
# end
# end