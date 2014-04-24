require "./library.rb"
# require 'pry-debugger'

describe Book do
  # Use let outside of tests to define variables across all tests.
  let(:book) {Book.new("The Stranger", "Albert Camus")}
  let(:borrower) { Borrower.new("David") }
  it "has a title and author, and nil id" do
    # binding.pry

    expect(book.title).to eq "The Stranger"
    expect(book.author).to eq "Albert Camus"
    expect(book.id).to be_nil
  end

  it "has a default status of available" do
    expect(book.status).to eq 'available'
  end

  it "can be checked out" do
    did_it_work = book.check_out
    expect(did_it_work).to be_true
    expect(book.status).to eq 'checked_out'
  end

  it "can't be checked out twice in a row" do
    did_it_work = book.check_out
    expect(did_it_work).to be_true
    expect(book.status).to eq 'checked_out'

    did_it_work_again = book.check_out
    expect(did_it_work_again).to eq(false)

    expect(book.status).to eq 'checked_out'
  end

  it "can be checked in" do
    book.check_out
    book.check_in
    expect(book.status).to eq 'available'
  end

  it "can have a year published and edition" do
    book1 = Book.new("The Stranger", "Albert Camus", {:year_published => "2005"})
    book2 = Book.new("The Stranger", "Albert Camus", {:edition => 4})
    expect(book1.year_published).to eq "2005"
    expect(book1.edition).to eq nil
    expect(book2.year_published).to eq nil
    expect(book2.edition).to eq 4
  end

  it "can have reviews left by borrowers" do
    borrower.leave_review(book,5,"Great")
    expect(book.ratings.first).to eq 5
    expect(book.reviews.first).to eq "Great"
  end

end

describe Borrower do
  let(:borrower) { Borrower.new("David") }
  it "has a name" do
    expect(borrower.name).to eq "David"
  end
end

describe Library do
  let(:lib) { Library.new("Public Library") }
  let(:david) { Borrower.new("David") }
  let(:mike) { Borrower.new("Mike")}
  let(:book) { Book.new("Nausea","Jean-Paul Sartre") }
  let(:book1) { Book.new("Eloquent JavaScript", "Marijn Haverbeke") }
  let(:book2) { Book.new("Essential JavaScript Design Patterns", "Addy Osmani") }
  let(:book3) { Book.new("JavaScript: The Good Parts", "Douglas Crockford") }

  it "starts with an empty array of books" do
    expect(lib.books.count).to eq(0)
  end

  it "add new books and assigns it an id" do
    lib.register_new_book(book)
    expect(lib.books.count).to eq(1)

    created_book = lib.books.first
    expect(created_book.title).to eq "Nausea"
    expect(created_book.author).to eq "Jean-Paul Sartre"
    expect(created_book.id).to_not be_nil
  end

  it "can add multiple books" do
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)

    expect(lib.books.count).to eq(3)
  end

  it "allows a Borrower to check out a book" do
    lib.register_new_book(book)

    # Sam wants to check out Green Eggs and Ham
    book_checking_out = lib.check_out_book(book, david)

    # The checkout should return the book
    expect(book_checking_out).to be_a(Book)
    expect(book_checking_out.title).to eq "Nausea"

    # The book should now be marked as checked out
    expect(book.status).to eq 'checked_out'
  end

  it "knows who borrowed a book" do
    lib.register_new_book(book)

    # Big Brother wants to check out The Brothers Karamazov
    lib.check_out_book(book, david)

    # The Library should know that he checked out the book
    expect( lib.get_borrower(book) ).to eq 'David'
  end

  it "does not allow a book to be checked out twice in a row" do
    lib.register_new_book(book)

    # Leslie Nielsen wants to double check on that
    lib.check_out_book(book, david)

    expect(book.status).to eq 'checked_out'

    # However, you can't check out the same book twice!

    lib.check_out_book(book, mike)
    expect(lib.borrowers[book].name).to eq 'David'
  end

  it "allows a Borrower to check a book back in" do
    lib.register_new_book(book)

    # Bob wants to check out Finnegans Wake
    lib.check_out_book(book, david)

    # o wait he changed his mind
    lib.check_in_book(book)

    # The book should now be marked as available!
    expect(book.status).to eq 'available'

    # The borrower of the book should be removed from the borrowers hash
    expect(lib.borrowers).not_to have_key(book.title)
  end

  it "does not allow a Borrower to check out more than two Books at any given time" do
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)

    # The first two books should check out fine
    book = lib.check_out_book(book1, david)
    expect(book.title).to eq "Eloquent JavaScript"

    book = lib.check_out_book(book2, david)
    expect(book.title).to eq "Essential JavaScript Design Patterns"

    # However, the third should return nil
    book = lib.check_out_book(book3, david)
    expect(book).to be_nil
  end

  it "returns available books" do
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)

    # At first, all books are available
    expect(lib.available_books.count).to eq(3)
    expect(lib.available_books.first).to be_a(Book)

    book = lib.check_out_book(lib.available_books.first, david)

    # But now, there should only be two available books
    expect(lib.available_books.count).to eq(2)
  end

  it "after a book it returned, it can be checked out again" do
    lib.register_new_book(book)

    # First, we check out the book
    lib.check_out_book(book, david)
    expect( lib.get_borrower(book) ).to eq 'David'

    # When we check in a book, the Library does not care who checks it in
    lib.check_in_book(book)

    # Another person should be able to check the book out
    lib.check_out_book(book, mike)
    expect( lib.get_borrower(book) ).to eq 'Mike'
  end

  it "returns borrowed books" do
    lib.register_new_book(book1)
    lib.register_new_book(book2)
    lib.register_new_book(book3)

    # At first, no books are checked out
    expect(lib.borrowed_books.count).to eq(0)

    book = lib.check_out_book(lib.available_books.first, david)

    # But now there should be one checked out book
    expect(lib.borrowed_books.count).to eq(1)
    expect(lib.borrowed_books.first).to be_a(Book)
  end

  it "it allows books to be imported from csv files" do
    expect(lib.books.count).to eq 0
    book_import = lib.import_from_csv('test.csv')
    expect(lib.books.count).to eq 2
    expect(lib.books.first.title).to eq "Green Eggs and Ham"
    expect(lib.books.last.title).to eq "Harry Potter"
  end

  it "sets a due date when a book is borrowed" do

    lib.check_out_book(book1,david)
    due_on = Time.now + (86400*7)
    expect(book1.due_date).to be_within(10).of(due_on)
  end

  it "marks overdue books as overdue" do
    book1 = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    kors = Borrower.new("Michael Kors")

    lib.check_out_book(book1, kors)
    lib.overdue_books(book1,Time.now + (86400*10))
    expect(book1.overdue).to eq true
  end

  it "does not allow borrowers with overdue books to check_out a new book" do
    book1 = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    kors = Borrower.new("Michael Kors")

    lib.check_out_book(book1, kors)
    lib.overdue_books(book1,Time.now + (86400*10))
    lib.check_out_book(book2,kors)
    expect(book2.status).to eq 'available'
  end

  it "allows borrowers to add checked out books to their queue" do
    lib.check_out_book(book,david)
    lib.check_out_book(book,mike)

    expect(lib.queued_books.length).to eq 1
  end

  it "checks out books in queue when they are returned" do
    lib.check_out_book(book,david)
    lib.check_out_book(book,mike)
    lib.check_in_book(book)

    expect(book.status).to eq 'checked_out'
  end
end
