require "./library.rb"
# require 'pry-debugger'

describe Book do
  it "has a title and author, and nil id" do
    book = Book.new("The Stranger", "Albert Camus")

    # binding.pry

    expect(book.title).to eq "The Stranger"
    expect(book.author).to eq "Albert Camus"
    expect(book.id).to be_nil
  end

  it "has a default status of available" do
    book = Book.new("The Stranger", "Albert Camus")
    expect(book.status).to eq 'available'
  end

  it "can be checked out" do
    book = Book.new("The Stranger", "Albert Camus")
    did_it_work = book.check_out
    expect(did_it_work).to be_true
    expect(book.status).to eq 'checked_out'
  end

  it "can't be checked out twice in a row" do
    book = Book.new("The Stranger", "Albert Camus")
    did_it_work = book.check_out
    expect(did_it_work).to be_true
    expect(book.status).to eq 'checked_out'

    did_it_work_again = book.check_out
    expect(did_it_work_again).to eq(false)

    expect(book.status).to eq 'checked_out'
  end

  it "can be checked in" do
    book = Book.new("The Stranger", "Albert Camus")
    book.check_out
    book.check_in
    expect(book.status).to eq 'available'
  end

  it "can have a year published and edition" do
    book = Book.new("The Stranger", "Albert Camus", {:year_published => "1900", :edition => 1})
    book1 = Book.new("The Stranger", "Albert Camus", {:year_published => "2005"})
    book2 = Book.new("The Stranger", "Albert Camus", {:edition => 4})
    expect(book.year_published).to eq "1900"
    expect(book.edition).to eq 1
    expect(book1.year_published).to eq "2005"
    expect(book1.edition).to eq nil
    expect(book2.year_published).to eq nil
    expect(book2.edition).to eq 4
  end

  it "can have reviews left by borrowers" do
    book = Book.new("The Stranger", "Albert Camus")
    borrower = Borrower.new("David")
    borrower.leave_review(book,5,"Great")
    expect(book.ratings.first).to eq 5
    expect(book.reviews.first).to eq "Great"
  end

end

describe Borrower do
  it "has a name" do
    borrower = Borrower.new("Mike")
    expect(borrower.name).to eq "Mike"
  end
end

describe Library do

  it "starts with an empty array of books" do
    lib = Library.new("Public Library")
    expect(lib.books.count).to eq(0)
  end

  it "add new books and assigns it an id" do
    lib = Library.new("Public Library")
    book = Book.new("Nausea","Jean-Paul Sartre")
    lib.register_new_book(book)
    expect(lib.books.count).to eq(1)

    created_book = lib.books.first
    expect(created_book.title).to eq "Nausea"
    expect(created_book.author).to eq "Jean-Paul Sartre"
    expect(created_book.id).to_not be_nil
  end

  it "can add multiple books" do
    lib = Library.new("Public Library")
    book1 = Book.new("Nausea","Jean-Paul Sartre")
    book2 = Book.new("Nausea","Jean-Paul Sartre")
    book3 = Book.new("Nausea","Jean-Paul Sartre")
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)

    expect(lib.books.count).to eq(3)
  end

  it "allows a Borrower to check out a book by its id" do
    lib = Library.new("Public Library")
    book = Book.new("Green Eggs and Ham","Dr. Seuss")
    lib.register_new_book(book)
    book_id = lib.books.first.id

    # Sam wants to check out Green Eggs and Ham
    sam = Borrower.new('Sam-I-am')
    book_checking_out = lib.check_out_book(book, sam)

    # The checkout should return the book
    expect(book_checking_out).to be_a(Book)
    expect(book_checking_out.title).to eq "Green Eggs and Ham"

    # The book should now be marked as checked out
    expect(book.status).to eq 'checked_out'
  end

  it "knows who borrowed a book" do
    lib = Library.new("Public Library")
    book = Book.new("The Brothers Karamazov", "Fyodor Dostoesvky")
    lib.register_new_book(book)
    book_id = lib.books.first.id

    # Big Brother wants to check out The Brothers Karamazov
    bro = Borrower.new('Big Brother')
    book = lib.check_out_book(book, bro)

    # The Library should know that he checked out the book
    expect( lib.get_borrower(book) ).to eq 'Big Brother'
  end

  it "does not allow a book to be checked out twice in a row" do
    lib = Library.new("Public Library")
    book = Book.new("Surely You're Joking Mr. Feynman", "Richard Feynman")
    lib.register_new_book(book)
    book_id = lib.books.first.id

    # Leslie Nielsen wants to double check on that
    nielsen = Borrower.new('Leslie Nielsen')
    book = lib.check_out_book(book, nielsen)

    # The first time should be successful
    expect(book).to be_a(Book)

    # However, you can't check out the same book twice!
    book_again = lib.check_out_book(book, nielsen)
    expect(book_again).to be_nil

    son = Borrower.new('Leslie Nielsen the 2nd')
    book_again = lib.check_out_book(book, son)
    expect(book_again).to be_nil
  end

  it "allows a Borrower to check a book back in" do
    lib = Library.new("Public Library")
    book = Book.new("Finnegans Wake", "James Joyce")
    lib.register_new_book(book)
    book_id = lib.books.first.id

    # Bob wants to check out Finnegans Wake
    bob = Borrower.new('Bob Bobber')
    book = lib.check_out_book(book, bob)

    # o wait he changed his mind
    lib.check_in_book(book)

    # The book should now be marked as available!
    expect(book.status).to eq 'available'

    # The borrower of the book should be removed from the borrowers hash
    expect(lib.borrowers).not_to have_key(book.title)
  end

  it "does not allow a Borrower to check out more than two Books at any given time" do
    # yeah it's a stingy library
    lib = Library.new("Public Library")

    book1 = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    book2 = Book.new("Essential JavaScript Design Patterns", "Addy Osmani")
    book3 = Book.new("JavaScript: The Good Parts", "Douglas Crockford")
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)
    jackson = Borrower.new("Michael Jackson")

    # The first two books should check out fine
    book = lib.check_out_book(book1, jackson)
    expect(book.title).to eq "Eloquent JavaScript"

    book = lib.check_out_book(book2, jackson)
    expect(book.title).to eq "Essential JavaScript Design Patterns"

    # However, the third should return nil
    book = lib.check_out_book(book3, jackson)
    expect(book).to be_nil
  end

  it "returns available books" do
    lib = Library.new("Public Library")
    book1 = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    book2 = Book.new("Essential JavaScript Design Patterns", "Addy Osmani")
    book3 = Book.new("JavaScript: The Good Parts", "Douglas Crockford")
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)

    # At first, all books are available
    expect(lib.available_books.count).to eq(3)
    expect(lib.available_books.first).to be_a(Book)

    jordan = Borrower.new("Michael Jordan")
    book = lib.check_out_book(lib.available_books.first, jordan)

    # But now, there should only be two available books
    expect(lib.available_books.count).to eq(2)
  end

  it "after a book it returned, it can be checked out again" do
    lib = Library.new("Public Library")
    book = Book.new("Harry Potter", "J. K. Rowling")
    lib.register_new_book(book)

    # First, we check out the book
    vick = Borrower.new("Michael Vick")
    book = lib.check_out_book(book, vick)
    expect( lib.get_borrower(book) ).to eq 'Michael Vick'

    # When we check in a book, the Library does not care who checks it in
    lib.check_in_book(book)

    # Another person should be able to check the book out
    schumacher = Borrower.new("Michael Schumacher")
    book = lib.check_out_book(book, schumacher)
    expect( lib.get_borrower(book) ).to eq 'Michael Schumacher'
  end

  it "returns borrowed books" do
    lib = Library.new("Public Library")
    book1 = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    book2 = Book.new("Essential JavaScript Design Patterns", "Addy Osmani")
    book3 = Book.new("JavaScript: The Good Parts", "Douglas Crockford")
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)

    # At first, no books are checked out
    expect(lib.borrowed_books.count).to eq(0)

    kors = Borrower.new("Michael Kors")
    book = lib.check_out_book(lib.available_books.first, kors)

    # But now there should be one checked out book
    expect(lib.borrowed_books.count).to eq(1)
    expect(lib.borrowed_books.first).to be_a(Book)
  end

  it "it allows books to be imported from csv files" do
    lib = Library.new("Public Library")
    expect(lib.books.count).to eq 0
    book_import = lib.import_from_csv('test.csv')
    expect(lib.books.count).to eq 2
    expect(lib.books.first.title).to eq "Green Eggs and Ham"
    expect(lib.books.last.title).to eq "Harry Potter"
  end
end
