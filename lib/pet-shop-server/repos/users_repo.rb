module Blogtastic
  class UsersRepo
    def self.all db 
      sql = %q[select * from posts]
      result = db.exec(sql)
      result.entries
    end

    def self.find db, id
      sql = %[select * from pets where id = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.find_by_name db, name
      sql = %[select * from pets]
    end
  end
end