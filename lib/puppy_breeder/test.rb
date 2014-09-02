ints = [1,2,3,4,5]
new_ints = []
ints.collect{|int| if int > 3 then new_ints.push(int) end}

p new_ints