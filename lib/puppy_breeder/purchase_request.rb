require 'pry-byebug'
#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  module Repos
    class PurchaseRequest
      attr_accessor :breed, :status, :id_count, :id_num, :open_orders, :completed_orders, :on_hold

      @@id_count = 0
      # @@open_orders = { }
      @@on_hold = [ ]

      def initialize(breed,status='pending',id_num=@id_count)
        @db = PG.connect(host: 'localhost', name: 'puppy-breeder')
        build_tables

        @breed = breed
        @status = status
        # @id_num = @@id_count
        # @@id_count += 1
        # @proirity = nil
        # @@open_orders[@id_num] = self
      end

      def build_tables
        #must run createdb requests in terminal
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text,
            price #FOREIGN KEY FROM BREEDER
            )
          ])
      end

      def open_orders
        result = @db.exec('SELECT * FROM requests;')
        # result.entries
        ########################
        # RESULT FROM RESULT.ENTIRES
        # [{"breed"=>"boxer","status"=>"pending"}]
        ########################
        build_request(result.entries)
      end

      def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::Repos::PurchaseRequest.new(req['breed'])
          x.instance_variable_set :@id, req["id"].to_i
          x.instance_variable_set :@status, req["status"].to_sym
        end
      end

      def accept(entires)
        result = @db.exec('SELECT * FROM mks WHERE id = ')
      end

      def reject(order_id)
        @@open_orders[order_id].status = 'rejected'
      end

      def hold(order_id)
        @@open_orders[order_id].status = 'hold'
        @@on_hold.push(@@open_orders[order_id])
      end
      
      def orders
        @@open_orders.select { |k,v| v.status == 'accepted' || v.status == 'rejected' || v.status == 'pending' }
      end

      def self.completed
        @@open_orders.select { |k,v| v.status == 'accepted' }
      end

      def self.on_hold
        @@on_hold
      end
    end
  end
end