
class DBI
		def initialize #single state instances
			@db = PG.connect(host: 'localhost', dbname: 'petbreeder')
			# another line I missed
    end

    def build_puppy(data)
      Puppy.new(data["name"], data["dob"], data["breed"],  data["id"], data["status"])
    end
    ##when in sinatra, first send info to DB, returning *, then build the object

    def get_all_puppies
      response = @db.exec("SELECT * FROM puppies;")
      response.map {|row| build_puppy(row)}
    end
    
    def get_puppies_by_breed(this_breed)
      response = @db.exec("SELECT * FROM puppies WHERE breed = '#{this_breed}';")
      response.map {|row| build_puppy(row)}
    end


    def build_request (data)
     Request.new(data["customer"], data["breed"], data["id"], data["created_at"], data["status"], data["puppy"])  ####make a new request -- check my syntax! 
    end
    
    def find_request_by_id(id)
      response = @db.exec("SELECT.....WHERE id = #{id}")
      build_request(response.first)
    end
    
    def add_puppy_to_db(name, breed, dob)
      @db.exec(%q[
        INSERT INTO puppies (name, breed, dob)
        VALUES (name, breed, dob)
        ])
    end


		#at bottom...SINGLETON
		def self.dbi
			@__db_instance ||= DBI.new
		end
end

#call by
DBI.dbi.whichever_command_from_this_class