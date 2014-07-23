# class CarStats < Car 
#     def self.calc_top_color(array_cars)
#       array_car_color = array_cars.map { |x| x.color} 
#       color_count_array = array_car_color.uniq.map do |x|
#       {:x => array_car_color.count(x)}
#       end 
#       colors_number = color_count_array.map do |x|
#       x.values 
#       end
#       max_color_number = colors_number.first
#       colors_number.each do |x|
#           if x > max_color_number
#             max_color_number = x
#           else 
#             max_color_number
#           end
#         end      
#         max_color_number
#         color_count_array.select{|x| x.has_value?(max_color_number)}
#     end  
# end

 class CarStats < Car 
    def self.calc_top_color(array_cars)
      array_car_color = array_cars.map {|x| x.color} 
      color_count = array_car_color.uniq.map {|x| array_car_color.count(x)}
      max_color_number = color_count.first
      color_count.each do |x|
          if x > max_color_number
            max_color_number = x
          else 
            max_color_number
          end
        end      
        max_color_number
        pop_color = array_car_color.find do |x| 
          array_car_color.count(x) == max_color_number
        end 
      end

      def self.calc_bottom_color(array_cars)
      array_car_color = array_cars.map {|x| x.color} 
      color_count = array_car_color.uniq.map {|x| array_car_color.count(x)}
      min_color_number = color_count.first
      color_count.each do |x|
          if x < min_color_number
            min_color_number = x
          else 
            min_color_number
          end
        end      
        min_color_number
        least_pop_color = array_car_color.find do |x| 
          array_car_color.count(x) == min_color_number
        end 
      end
end     