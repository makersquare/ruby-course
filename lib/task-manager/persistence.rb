require 'pg'


class TM::Connector 


	def initialize
		@db = PG.connect(host: 'localhost', dbname: 'task-manager')
	end

	def save_project(pj)
		id = @db.exec("insert into projects (name)
		 values($1) returning id;",[pj.name])
		pj.save!(id)
	end

	def save_employee(em)
		id = @db.exec("insert into employees (name)
			values($1) returning id",[em.name])
		em.save!(id[0]['id'])
	end

	def get_projects()
		list_p = @db.exec('select * from projects')
	end

	def save_task(task)

		begin

		@db.exec('BEGIN')

		id = @db.exec('insert into tasks (description,priority,
			state_complete,creation,p_id)
		values($1,$2,$3,$4,$5) returning id',[task.desc,task.priority,
		task.state_complete,task.creation_date,task.p_id])
		
		@db.exec('insert into tasks_projects (p_id,t_id)
		values($1,$2)',[task.p_id.to_i,id[0]['id']])
		@db.exec('COMMIT')
		
		rescue PG::Error => err
		p [
		err.result.error_field( PG::Result::PG_DIAG_SEVERITY ), 
        err.result.error_field( PG::Result::PG_DIAG_SQLSTATE ),
        err.result.error_field( PG::Result::PG_DIAG_MESSAGE_PRIMARY ),
        err.result.error_field( PG::Result::PG_DIAG_MESSAGE_DETAIL ),
        err.result.error_field( PG::Result::PG_DIAG_MESSAGE_HINT ),
        err.result.error_field( PG::Result::PG_DIAG_STATEMENT_POSITION ),
        err.result.error_field( PG::Result::PG_DIAG_INTERNAL_POSITION ),
        err.result.error_field( PG::Result::PG_DIAG_INTERNAL_QUERY ),
        err.result.error_field( PG::Result::PG_DIAG_CONTEXT ),
        err.result.error_field( PG::Result::PG_DIAG_SOURCE_FILE ),
        err.result.error_field( PG::Result::PG_DIAG_SOURCE_LINE ),
        err.result.error_field( PG::Result::PG_DIAG_SOURCE_FUNCTION ),

			]
		return false

		end

		task.save!(id[0]['id'])

	end

	def rem_tasks(p_id)

		list_t = @db.exec('select * from tasks where state_complete
		 = false and p_id = $1 order by priority, creation',[p_id.to_i])
		return list_t
	end

	def com_tasks(p_id)
		list_t = @db.exec('select * from tasks where 
			state_complete = True and p_id = $1', [p_id.to_i])
		return list_t
	end

	def mark_complete(t_id)
		@db.exec('update tasks set state_complete = true
			where id = $1',[t_id.to_i])
	end

	def get_employees()
		list = @db.exec('select * from employees')
		return list
	end

	# add as an extra
	def active_employees_on_proj(p_id)
		list = @db.exec('select e.id as id, e.name as name  
			from employees as e, 
			employees_tasks as et, 
			tasks_projects as tp
			where e.id = et.e_id and et.t_id = tp.t_id
			and tp.p_id = $1',[p_id])
		return list
	end

	def employees_on_proj(p_id)

		

		list = @db.exec('select e.id as id, e.name as name  
			from employees as e, 
			employees_projects as ep
			where e.id = ep.e_id and
			and ep.p_id = $1 group by e.id',[p_id])
		return list
	end

	def assign_task(t_id,e_id)
		@db.exec('insert into employees_tasks (t_id,e_id)
			values($1,$2)',[t_id.to_i,e_id.to_i])	
	end

	
	def get_emp_proj(e_id)
		list = @db.exec('select p.id as id, p.name as name  
			from 
			employees_projects as ep, 
			projects as p
			where ep.e_id = p.id and ep.e_id = $1
			group by p.id',[e_id])
		return list
	end

	# add as an extra
	def get_emp_active_proj(e_id)
		list = @db.exec('select p.id as id, p.name as name  
			from employees as e, 
			employees_tasks as et, 
			tasks_projects as tp, projects as p
			where e.id = et.e_id and et.t_id = tp.t_id
			and p.id = tp.p_id and e.id = $1',[e_id])
		return list
	end

	def get_employee_id(e)
		emp = @db.exec('select * from employees where id = $1',
			[e])
		return emp
	end

	def emp_x_tasks(e_id,state)
		list = @db.exec('select t.id as tid,t.description as tdesc, 
			p.name as pname from employees_tasks as et,
			tasks_projects as tp, 
			tasks as t, projects as p
			where
			t.id = tp.t_id and p.id = tp.p_id 
			and et.t_id = tp.t_id and t.state_complete = $2
			and et.e_id = $1',[e_id,state])
		return list
	end

	def check_res_avi(t_id,e_id)
		res=@db.exec('select ep.e_id as id from tasks_projects as tp,
			employees_projects as ep where
			tp.t_id=$1 and tp.p_id = ep.p_id
			and ep.e_id = $2',[t_id.to_i,e_id.to_i])
		if res.num_tuples.zero?
			return false
		else
			return true
		end
	end

	def recruit(p_id,e_id)
		@db.exec('insert into employees_projects
			(p_id,e_id) values($1,$2)',[p_id.to_i,e_id.to_i])
		
	end
end
