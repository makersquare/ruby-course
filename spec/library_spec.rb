require "./custom_library.rb"

describe Book do
  it "has a title and author, and nil id" do
    book = Book.new(title: "The Stranger", author: "Albert Camus")

    # binding.pry

    expect(book.title).to eq "The Stranger"
    expect(book.author).to eq "Albert Camus"
    expect(book.id).to be_nil
  end

  it "has a default status of available" do
    book = Book.new
    expect(book.status).to eq 'available'
  end

  it "can be checked out" do
    book = Book.new
    did_it_work = book.check_out
    expect(did_it_work).to be_true
    expect(book.status).to eq 'checked_out'
  end

  it "can't be checked out twice in a row" do
    book = Book.new
    did_it_work = book.check_out
    expect(did_it_work).to eq(true)

    did_it_work_again = book.check_out
    expect(did_it_work_again).to eq(false)

    expect(book.status).to eq 'checked_out'
  end

  it "can be checked in" do
    book = Book.new
    book.check_out
    book.check_in
    expect(book.status).to eq 'available'
  end
end

describe Borrower do
  it "has a name" do
    borrower = Borrower.new(name: "Mike")
    expect(borrower.name).to eq "Mike"
  end
end

describe Library do

  it "starts with an empty array of books" do
    lib = Library.new
    expect(lib.books.count).to eq(0)
  end

  it "add new books and assigns it an id" do
    lib = Library.new
    lib.register_new_book("Nausea", "Jean-Paul Sartre")
    expect(lib.books.count).to eq(1)

    created_book = lib.books.first
    expect(created_book.title).to eq "Nausea"
    expect(created_book.author).to eq "Jean-Paul Sartre"
    expect(created_book.id).to_not be_nil
  end

  it "can add multiple books" do
    lib = Library.new
    lib.register_new_book("One", "Bob")
    lib.register_new_book("Two", "Bob")
    lib.register_new_book("Three", "Bob")

    expect(lib.books.count).to eq(3)
  end

  it "allows a Borrower to check out a book by its id" do
    lib = Library.new
    lib.register_new_book("Green Eggs and Ham", "Dr. Seuss")
    book_id = lib.books.first.id

    # Sam wants to check out Green Eggs and Ham
    sam = Borrower.new(name: 'Sam-I-am')
    book = lib.check_out_book(book_id, sam)

    # The checkout should return the book
    expect(book).to be_a(Book)
    expect(book.title).to eq "Green Eggs and Ham"

    # The book should now be marked as checked out
    expect(book.status).to eq 'checked_out'
  end

  it "knows who borrowed a book" do
    lib = Library.new
    lib.register_new_book("The Brothers Karamazov", "Fyodor Dostoesvky")
    book_id = lib.books.first.id

    # Big Brother wants to check out The Brothers Karamazov
    bro = Borrower.new(name: 'Big Brother')
    book = lib.check_out_book(book_id, bro)

    # The Library should know that he checked out the book
    expect( lib.get_borrower(book_id) ).to eq 'Big Brother'
  end

  it "does not allow a book to be checked out twice in a row" do
    lib = Library.new
    lib.register_new_book("Surely You're Joking Mr. Feynman", "Richard Feynman")
    book_id = lib.books.first.id

    # Leslie Nielsen wants to double check on that
    nielsen = Borrower.new(name: 'Leslie Nielsen')
    book = lib.check_out_book(book_id, nielsen)

    # The first time should be successful
    expect(book).to be_a(Book)

    # However, you can't check out the same book twice!
    book_again = lib.check_out_book(book_id, nielsen)
    expect(book_again).to be_nil

    son = Borrower.new(name: 'Leslie Nielsen the 2nd')
    book_again = lib.check_out_book(book_id, son)
    expect(book_again).to be_nil
  end

  it "allows a Borrower to check a book back in" do
    lib = Library.new
    lib.register_new_book("Finnegans Wake", "James Joyce")
    book_id = lib.books.first.id

    # Bob wants to check out Finnegans Wake
    bob = Borrower.new(name: 'Bob Bobber')
    book = lib.check_out_book(book_id, bob)

    # o wait he changed his mind
    lib.check_in_book(book)

    # The book should now be marked as available!
    expect(book.status).to eq 'available'
  end

  it "does not allow a Borrower to check out more than one Book at any given time" do
    # yeah it's a stingy library
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    jackson = Borrower.new(name: "Michael Jackson")
    book_1 = lib.books[0]
    book_2 = lib.books[1]
    book_3 = lib.books[2]

    # The first two books should check out fine
    book = lib.check_out_book(book_1.id, jackson)
    expect(book.title).to eq "Eloquent JavaScript"

    book = lib.check_out_book(book_2.id, jackson)
    expect(book.title).to eq "Essential JavaScript Design Patterns"

    # However, the third should return nil
    book = lib.check_out_book(book_3.id, jackson)
    expect(book).to be_nil
  end

  it "returns available books" do
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    # At first, all books are available
    expect(lib.available_books.count).to eq(3)
    expect(lib.available_books.first).to be_a(Book)

    jordan = Borrower.new(name: "Michael Jordan")
    book = lib.check_out_book(lib.available_books.first.id, jordan)

    # But now, there should only be two available books
    expect(lib.available_books.count).to eq(2)
  end

  it "after a book it returned, it can be checked out again" do
    lib = Library.new
    lib.register_new_book("Harry Potter", "J. K. Rowling")
    book_id = lib.books.first.id

    # First, we check out the book
    vick = Borrower.new(name: "Michael Vick")
    book = lib.check_out_book(book_id, vick)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Vick'

    # When we check in a book, the Library does not care who checks it in
    lib.check_in_book(book)

    # Another person should be able to check the book out
    schumacher = Borrower.new(name: "Michael Schumacher")
    book = lib.check_out_book(book_id, schumacher)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Schumacher'
  end

  it "returns borrowed books" do
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    # At first, no books are checked out
    expect(lib.borrowed_books.count).to eq(0)

    kors = Borrower.new(name: "Michael Kors")
    book = lib.check_out_book(lib.books.first.id, kors)

    # But now there should be one checked out book
    expect(lib.borrowed_books.count).to eq(1)
    expect(lib.borrowed_books.keys.first).to be_a(Book)
  end
end
