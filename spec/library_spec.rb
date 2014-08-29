require "./library.rb"
require 'pry-byebug'

describe Book do
  it "has a title and author, and nil id" do
    book = Book.new("The Stranger", "Albert Camus")

    # binding.pry

    expect(book.title).to eq "The Stranger"
    expect(book.author).to eq "Albert Camus"
    expect(book.id).to be_nil
  end

  it "has a default status of available" do
    #added name, author arguements -> a book can never not have those!
    book = Book.new("The Stranger", "Albert Camus")
    expect(book.status).to eq 'available'
  end

  it "can be checked out" do
    #added name, author arguements -> a book can never not have those!
    book = Book.new("The Stranger", "Albert Camus")
    did_it_work = book.check_out
    expect(did_it_work).to be_true
    expect(book.status).to eq 'checked_out'
  end

  it "can't be checked out twice in a row" do
    #added name, author arguements -> a book can never not have those!
    book = Book.new("The Stranger", "Albert Camus")
    did_it_work = book.check_out
    expect(did_it_work).to eq(true)

    did_it_work_again = book.check_out
    expect(did_it_work_again).to eq(false)

    expect(book.status).to eq 'checked_out'
  end

  it "can be checked in" do
    #added name, author arguements -> a book can never not have those!
    book = Book.new("The Stranger", "Albert Camus")
    book.check_out
    book.check_in
    expect(book.status).to eq 'available'
  end

  # added extension tests

  it 'has attribute year published' do

    book1 = Book.new("The Stranger", "Albert Camus", {year: 1990})

    expect(book1.year).to eq(1990)
    
  end

  it 'has attribute edition' do
    book1 = Book.new("The Stranger", "Albert Camus", {edition: "10th"})

    expect(book1.edition).to eq("10th")
  end


end


describe Borrower do

  it "has a name" do
    borrower = Borrower.new("Mike")
    expect(borrower.name).to eq "Mike"
  end

  #extension tests

  it 'borrower can leave review on a book with both a rating and optional written review' do

    billy = Borrower.new("Billy")
    book1 = Book.new("The Stranger", "Albert Camus")
    book2 = Book.new("Nausea", "Jean-Paul Sartre")

    billy.review_book(book1, 2)git
    billy.review_book(book2, 3, review: "This book made me sick")

    expect(book1.reviews[0][0]).to eq(2)
    expect(book2.reviews[0][0]).to eq(3)


    expect(book1.reviews[0][1]).to eq("no review was written")
    expect(book2.reviews[0][1]).to eq("This book made me sick")

  end
end

describe Library do

  it "starts with an empty array of books" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    expect(lib.books.count).to eq(0)
  end

  it "add new books and assigns it an id" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    #changed lib.register_new_book to lib.add_book
    lib.add_book("Nausea", "Jean-Paul Sartre")
    expect(lib.books.count).to eq(1)

    created_book = lib.books.first
    expect(created_book.title).to eq "Nausea"
    expect(created_book.author).to eq "Jean-Paul Sartre"
    expect(created_book.id).to_not be_nil
  end

  it "can add multiple books" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("One", "Bob")
    lib.add_book("Two", "Bob")
    lib.add_book("Three", "Bob")

    expect(lib.books.count).to eq(3)
  end

  it "allows a Borrower to check out a book by its id" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("Green Eggs and Ham", "Dr. Seuss")
    #Changed to lib.books.LAST.id because books are pushed onto the array in the last position
    book_id = lib.books.first.id

    # Sam wants to check out Green Eggs and Ham
    sam = Borrower.new('Sam-I-am')
    book = lib.check_out_book(book_id, sam)

    # The checkout should return the book
    expect(book).to be_a(Book)
    expect(book.title).to eq "Green Eggs and Ham"

    # The book should now be marked as checked out
    expect(book.status).to eq 'checked_out'
  end

  it "knows who borrowed a book" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("The Brothers Karamazov", "Fyodor Dostoesvky")
    #books.last not books.first
    book_id = lib.books.last.id

    # Big Brother wants to check out The Brothers Karamazov
    bro = Borrower.new('Big Brother')
    book = lib.check_out_book(book_id, bro)

    # The Library should know that he checked out the book
    expect( lib.get_borrower(book_id) ).to eq 'Big Brother'
  end

  it "does not allow a book to be checked out twice in a row" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("Surely You're Joking Mr. Feynman", "Richard Feynman")
    book_id = lib.books.first.id

    # Leslie Nielsen wants to double check on that
    nielsen = Borrower.new('Leslie Nielsen')
    book = lib.check_out_book(book_id, nielsen)

    # The first time should be successful
    expect(book).to be_a(Book)

    # However, you can't check out the same book twice!
    book_again = lib.check_out_book(book_id, nielsen)
    expect(book_again).to be_nil

    son = Borrower.new('Leslie Nielsen the 2nd')
    book_again = lib.check_out_book(book_id, son)
    expect(book_again).to be_nil
  end

  it "allows a Borrower to check a book back in" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("Finnegans Wake", "James Joyce")
    book_id = lib.books.last.id

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
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.add_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.add_book("JavaScript: The Good Parts", "Douglas Crockford")

    jackson = Borrower.new("Michael Jackson")
    book_1 = lib.books[0]
    book_2 = lib.books[1]
    #book_3 = lib.books[2]

    
    book = lib.check_out_book(book_1.id, jackson)
    expect(book.title).to eq "Eloquent JavaScript"

    book = lib.check_out_book(book_2.id, jackson)
    expect(book).to be_nil

    # However, the third should return nil
    # book = lib.check_out_book(book_3.id, jackson)
    # expect(book).to be_nil
  end

  it "returns available books" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.add_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.add_book("JavaScript: The Good Parts", "Douglas Crockford")

    # At first, all books are available
    expect(lib.available_books.count).to eq(3)
    expect(lib.available_books.first).to be_a(Book)

    jordan = Borrower.new("Michael Jordan")
    book = lib.check_out_book(lib.available_books.first.id, jordan)

    # But now, there should only be two available books
    expect(lib.available_books.count).to eq(2)
  end

  it "after a book it returned, it can be checked out again" do
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("Harry Potter", "J. K. Rowling")
    book_id = lib.books.last.id

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
    #made it so that library requries a name always
    lib = Library.new("Lib_Name")
    lib.add_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.add_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.add_book("JavaScript: The Good Parts", "Douglas Crockford")

    # At first, no books are checked out
    expect(lib.borrowed_books.count).to eq(0)

    kors = Borrower.new("Michael Kors")
    book = lib.check_out_book(lib.available_books.first.id, kors)

    # But now there should be one checked out book
    expect(lib.borrowed_books.count).to eq(1)
    expect(lib.borrowed_books.first).to be_a(Book)
  end

end
