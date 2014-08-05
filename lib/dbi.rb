require 'pg'

class DBI
		def initialize #single state instances
			@db = PG.connect(host: 'localhost', dbname: 'petbreeder')
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

    def get_puppies_by_status(this_status)
      response = @db.exec("SELECT * FROM puppies WHERE status = '#{this_status}';")
      response.map {|row| build_puppy(row)}
    end

    def get_puppies_by_status_and_breed(this_status, this_breed)
      response = @db.exec("SELECT * FROM puppies WHERE status = '#{this_status}' AND breed = '#{this_breed}';")
      response.map {|row| build_puppy(row)}
    end


    def build_request (data)
     Request.new(data["customer"], data["breed"], data["id"], data["timestamp"], data["status"], data["puppy"])  ####make a new request -- check my syntax! 
    end
    
    def get_requests_by_status(status)
      response = @db.exec("SELECT * FROM requests WHERE status = '#{status}';")
      response.map {|row| build_request(row)}
    end

    def get_requests_by_breed(breed)
      response = @db.exec("SELECT * FROM requests WHERE breed = '#{breed}';")
      response.map {|row| build_request(row)}
    end    

    def get_requests_by_status_and_breed(status, breed)
      response = @db.exec("SELECT * FROM requests WHERE breed = '#{breed}' AND status = '#{status}';")
      response.map {|row| build_request(row)}
    end  

    def get_all_requests
      response = @db.exec("SELECT * FROM requests;")
      response.map {|row| build_request(row)}
    end      



    def add_puppy_to_db(name, breed, dob)
      response = @db.exec("
        INSERT INTO puppies (name, breed, dob, status)
        VALUES ('#{name}', '#{breed}', '#{dob}', 'available')
        RETURNING *;
        ")
      response.map {|row| build_puppy(row)}
    end

    def add_request_to_db(name, breed)
      response = @db.exec("
        INSERT INTO requests (customer, breed, status)
        VALUES ('#{name}', '#{breed}', 'pending')
        RETURNING *;
        ")
      response.map {|row| build_request(row)}
    end    

    def get_all_breed_names
      response = @db.exec("SELECT breed FROM breeds;")
      response.map {|row| row["breed"]}
    end

    def make_breed_hash
      response = @db.exec("SELECT * FROM breeds;")
      pricing_hash = {}
      response.each  do |r| 
        b = r['breed']
        p = r['price']
        pricing_hash[b] = p
      end
      pricing_hash
    end

    def add_breed(breed, price)
      @db.exec("INSERT INTO breeds (breed, price) VALUES ('#{breed}', '#{price}');")
    end

		#at bottom...SINGLETON
		def self.dbi
			@__db_instance ||= DBI.new
		end
end

#call by
#DBI.dbi.whichever_command_from_this_class