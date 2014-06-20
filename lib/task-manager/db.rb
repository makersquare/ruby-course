require 'pg'
require 'pry-byebug'
module TM
  class DB
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'task-manager')
    end

    ### CREATE ###

    def create(sklass, args)
      keys   = args.keys.join(", ")
      values = args.values.map { |s| "'#{s}'" }.join(', ')

      command = %Q[ INSERT INTO #{sklass} (#{keys})
                    VALUES (#{values})
                    returning *; ]

      execute_the(command, sklass)
    end

    ### READ ###

    def get(sklass, id)
      command = %Q[ SELECT * FROM #{sklass}
                    WHERE id = #{id}; ]

      execute_the(command, sklass)
    end

    ### UPDATE ###

    def update(sklass, id, args)
      keys   = args.keys.join(", ")
      values = args.values.map { |s| "'#{s}'" }.join(', ')

      command = %Q[ UPDATE #{sklass}
                    SET (#{keys}) = (#{values})
                    WHERE id = #{id}
                    returning *; ]

      execute_the(command, sklass)
    end

    ### DELETE ###

    def delete(sklass, id)
      command = %Q[ DELETE FROM #{sklass}
                    WHERE id = #{id}
                    returning *; ]

      execute_the(command, sklass)
    end

    private

    def get_klass(sklass)
      {projects:  TM::Project,
       employees: TM::Employee,
       tasks:     TM::Task }[sklass.to_sym]
    end

    def execute_the(command, sklass)
      klass = get_klass(sklass)

      results = @db.exec(command)

      new_results = parse_the(results).first

      begin
        klass.new( new_results )
      rescue
        nil
      end
    end

    def parse_the(results)
      presults = [ ]

      results.each do |result|
        presult = result.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}

        presult[:id         ] = presult[:id         ].to_i
        presult[:priority   ] = presult[:priority   ].to_i if presult[:priority]
        presult[:project_id ] = presult[:project_id ].to_i if presult[:project_id]
        presult[:employee_id] = presult[:employee_id].to_i if presult[:employee_id]
        if presult[:completed]
          presult[:completed] = (presult[:completed] == 'f' ? false : true)
        end
        presult[:created_at ] = Time.parse( presult[:created_at] ) if presult[:created_at]

        presults << presult
      end

      presults
    end

    private

    def db=(db)
      @db = db
    end
  end

  def self.db
    @_db_singleton ||= DB.new
  end
end
