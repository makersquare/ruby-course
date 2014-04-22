require "./library.rb"

    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    # At first, no books are checked out

    kors = Borrower.new("Michael Kors")
    puts lib.borrowed_books
    
    # book = lib.check_out_book(lib.borrowed_books.first.id, kors)
