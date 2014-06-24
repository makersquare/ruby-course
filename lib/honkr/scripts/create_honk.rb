module Honkr
  class CreateHonk

    def self.run(params)
      user = Honkr.db.get_user_by_session_id( params.delete(:session_id) )
      if user.nil?
        return { :success? => false, :error => :not_signed_in }
      end

      content = params[:content]
      if content.nil? || content == ''
        return { :success? => false, :error => :invalid_content }
      end

      honk = Honk.new(nil, user.id, content)
      Honkr.db.persist_honk(honk)

      return { :success? => true, :honk => honk }
    end

  end
end
