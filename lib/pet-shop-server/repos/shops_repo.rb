module PetShopServer
	class ShopsRepo
		def self.all db
			sql = %q[SELECT * FROM petshops]
			result = db.exec(sql)
			result.entries
		end

		def self.find db, id
			sql = %q[SELECT * FROM petshops WHERE id = $1]
			result = db.exec(sql, [id])
			result.first
		end
	end
end
