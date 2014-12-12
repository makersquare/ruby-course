module PetShopServer
  class UsersRepo
    def self.all db 
      sql = %q[select * from users]
      result = db.exec(sql)
      result.entries
    end

    def self.find db, id
      sql = %[select * from users where id = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.find_by_name db, name
      sql = %[select * from users WHERE username = $1]
      result = db.exec(sql, [name])
      result.first
    end
  end
end