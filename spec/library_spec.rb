require "./library2nd.rb"
require 'pry-debugger'
# Borrowers should be able to leave reviews on Books with both a rating and an optional written review.
describe Book do
  it "has a title and author, and nil id" do
    book = Book.new("The Stranger", "Albert Camus", 1984, 2)

    # binding.pry

    expect(book.title).to eq "The Stranger"
    expect(book.author).to eq "Albert Camus"
    expect(book.id).to be_nil # one
    expect(book.year).to eq 1984
    expect(book.edition). to eq 2
  end
                    # had title author here ---
  it "has a default status of available" do
    book = Book.new("The Stranger", "Albert Camus", 1984, 2) # commit
    expect(book.status).to eq 'available'
  end

  it "can be checked out" do # commit
    book = Book.new("The Stranger", "Albert Camus", 1984, 2)
    did_it_work = book.check_out
    expect(did_it_work).to eq(true)
    expect(book.status).to eq 'checked_out'
  end

  it "can't be checked out twice in a row" do
    book = Book.new("The Stranger", "Albert Camus", 1984, 2)
    did_it_work = book.check_out
    expect(did_it_work).to eq(true)

    did_it_work_again = book.check_out
    expect(did_it_work_again).to eq(false)

    expect(book.status).to eq 'checked_out'
  end

  it "can be checked in" do
    book = Book.new("The Stranger", "Albert Camus", 1984, 2)
    book.check_out
    book.check_in
    expect(book.status).to eq 'available'
  end
end

describe Borrower do
  it "has a name" do
    borrower = Borrower.new("Mike")
    expect(borrower.name).to eq "Mike"
  end

  it "leave a rating on book, and optional written opinion" do
    borrower = Borrower.new("Mike")
    book = Book.new("The Stranger", "Albert Camus", 1984, 2)

    expect(book.rating).to eq(nil)
    borrower.give_review(2,"good",book)
    expect(book.rating).to eq 2
    expect(book.opinion).to eq "good"

    expect(borrower.give_review(11,"good",book)).to eq ("please rate between 0 and 10")
  end

end

describe Library do

  it "starts with an empty array of books" do
    lib = Library.new("name")
    expect(lib.books.count).to eq(0)
  end

  it "add new books and assigns it an id" do
    lib = Library.new("name")
    lib.register_new_book("Nausea", "Jean-Paul Sartre", 1977, 4)
    expect(lib.books.count).to eq(1)

    created_book = lib.books.first
    expect(created_book.title).to eq "Nausea"
    expect(created_book.author).to eq "Jean-Paul Sartre"
    expect(created_book.id).to_not be_nil
  end

  it "can add multiple books" do
    lib = Library.new("name")
    lib.register_new_book("One", "Bob", 2008, 1)
    lib.register_new_book("Two", "Bob", 2009, 2)
    lib.register_new_book("Three", "Bob", 2010, 3)

    expect(lib.books.count).to eq(3)
  end

  it "allows a Borrower to check out a book by its id" do
    lib = Library.new("name")
    lib.register_new_book("Green Eggs and Ham", "Dr. Seuss", 1969, 2)
    book_id = lib.books.first.id

    # Sam wants to check out Green Eggs and Ham
    sam = Borrower.new('Sam-I-am')
    book = lib.check_out_book(book_id, sam)

    # The checkout should return the book
    expect(book).to be_a(Book)
    expect(book.title).to eq "Green Eggs and Ham"
    expect(book.edition). to eq 2
    expect(book.year). to eq 1969
    # The book should now be marked as checked out
    expect(book.status).to eq 'checked_out'
  end

  it "knows who borrowed a book" do
    lib = Library.new("name")
    lib.register_new_book("The Brothers Karamazov", "Fyodor Dostoesvky", 1929, 4)
    book_id = lib.books.first.id

    # Big Brother wants to check out The Brothers Karamazov
    bro = Borrower.new('Big Brother')
    book = lib.check_out_book(book_id, bro)

    # The Library should know that he checked out the book
    expect( lib.get_borrower(book_id) ).to eq 'Big Brother'
  end

  it "does not allow a book to be checked out twice in a row" do
    lib = Library.new("name")
    lib.register_new_book("Surely You're Joking Mr. Feynman", "Richard Feynman", 1982, 7)
    book_id = lib.books.first.id

    # Leslie Nielsen wants to double check on that
    nielsen = Borrower.new('Leslie Nielsen')
    book = lib.check_out_book(book_id, nielsen)

    # The first time should be successful
    expect(book).to be_a(Book) # how to run this in irb

    # However, you can't check out the same book twice!
    book_again = lib.check_out_book(book_id, nielsen)
    expect(book_again).to be_nil

    son = Borrower.new('Leslie Nielsen the 2nd')
    book_again = lib.check_out_book(book_id, son)
    expect(book_again).to be_nil
  end

  it "allows a Borrower to check a book back in" do
    lib = Library.new("name")
    lib.register_new_book("Finnegans Wake", "James Joyce", 1972, 4)
    book_id = lib.books.first.id

    # Bob wants to check out Finnegans Wake
    bob = Borrower.new('Bob Bobber')
    book = lib.check_out_book(book_id, bob)

    # o wait he changed his mind
    lib.check_in_book(book)

    # The book should now be marked as available!
    expect(book.status).to eq 'available'
  end

  it "does not allow a Borrower to check out more than one Book at any given time" do
    # yeah it's a stingy library
    lib = Library.new("name")
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke", 2011, 2)
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani", 2012, 7)
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford", 2009, 1)

    jackson = Borrower.new("Michael Jackson")
    book_1 = lib.books[0]
    book_2 = lib.books[1]
    book_3 = lib.books[2]
    # binding.pry
    # The first two books should check out fine
    book = lib.check_out_book(book_1.id, jackson) # why 2?
    expect(book.title).to eq "Eloquent JavaScript"
    expect(book.year). to eq 2011
    # binding.pry
    book = lib.check_out_book(book_2.id, jackson)
    expect(book.title).to eq "Essential JavaScript Design Patterns"
    expect(book.year). to eq 2012
    expect(book.edition). to eq 7
    # However, the third should return nil
    book = lib.check_out_book(book_3.id, jackson)
    expect(book).to be_nil
  end

  it "returns available books" do
    lib = Library.new("name")
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke", 2011, 2)
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani", 2012, 7)
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford", 2009, 1)

    # At first, all books are available
    expect(lib.available_books.count).to eq(3)
    expect(lib.available_books.first).to be_a(Book)

    jordan = Borrower.new("Michael Jordan")
    book = lib.check_out_book(lib.available_books.first.id, jordan)

    # But now, there should only be two available books
    expect(lib.available_books.count).to eq(2)
  end

  it "after a book it returned, it can be checked out again" do
    lib = Library.new("name")
    lib.register_new_book("Harry Potter", "J. K. Rowling", 2008, 2)
    book_id = lib.books.first.id

    # First, we check out the book
    vick = Borrower.new("Michael Vick")
    book = lib.check_out_book(book_id, vick)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Vick'

    # When we check in a book, the Library does not care who checks it in
    lib.check_in_book(book)

    # Another person should be able to check the book out
    schumacher = Borrower.new("Michael Schumacher")
    book = lib.check_out_book(book_id, schumacher)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Schumacher'
  end

  it "returns borrowed books" do
    lib = Library.new("name")
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke", 2011, 2)
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani", 2012, 7)
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford", 2009, 1)

    # At first, no books are checked out
    expect(lib.borrowed_books.count).to eq(0)

    kors = Borrower.new("Michael Kors")
    book = lib.check_out_book(lib.books.first.id, kors)
                                     #return nil, no one borrowed anything
    # But now there should be one checked out book
    expect(lib.borrowed_books.count).to eq(1)
    expect(lib.borrowed_books.first).to be_a(Book)
    expect(lib.books.first.year).to eq 2011
  end
end
