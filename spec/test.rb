require "./library.rb"

lib = Library.new
lib.register_new_book("The Brothers Karamazov", "Fyodor Dostoesvky")
book_id = lib.books.first.id

bro = Borrower.new('Big Brother')
book = lib.check_out_book(book_id, bro)
puts book.title

puts book_id
puts lib.get_borrower(book_id-1)
