# #Refer to this class as PuppyBreeder::Puppy
# module PuppyBreeder
#   class Puppy
#     attr_accessor :name, :breed, :age

#     def initialize(name,breed,age)
#       @db = PG.connect(host: 'localhost', name: 'puppy-breeder')

#       build_tables

#       @name = name
#       @breed = breed
#       @age = age
#     end
    
#     def build_tables
#       @db.exec(%q[
#         CREATE TABLE IF NOT EXISTS puppies(
#           id serial,
#           name text,
#           breed text,
#           age int
#           )
#         ])
#     end
#   end
# end