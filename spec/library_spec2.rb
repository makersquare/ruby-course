require './library2.rb'
require 'rspec'
require 'pry-byebug'
# binding.pry

describe Book do
  it "has a title and author" do
    book = Book.new(title: "The Stranger", author: "Albert Camus")
    expect(book.title).to eq "The Stranger"
    expect(book.author).to eq "Albert Camus"
  end

  it "can be corrected" do
    book = Book.new(title: "The Stranger", author: "Friedrich Nietzche")
    book.correct_info("author","Albert Camus")
    expect(book.author).to eq "Albert Camus"
  end
end


describe LibraryWrapper do
  it "holds a book object" do
    book = Book.new(title: "The Stranger", author: "Albert Camus")
    wrapper = LibraryWrapper.new(book)
    expect(wrapper.book).to be_a(Book)
  end

  it "has an empty array as the borrower list" do
    book = Book.new(title: "The Stranger", author: "Albert Camus")
    wrapper = LibraryWrapper.new(book)
    expect(wrapper.status).to eq("available")
  end  
end


describe BorrowerCard do
  it "has a name" do
    borrower = BorrowerCard.new("Mike")
    expect(borrower.name).to eq "Mike"
  end

  it "can borrow" do
    borrower = BorrowerCard.new("Mike")
    expect(borrower.eligible_borrower?).to be_true
  end
end


describe Library do
  it "starts with an empty hash of books and borrowers" do
    lib = Library.new(name: "Pritzker Law Library")
    expect(lib.books.count).to eq(0)
    expect(lib.borrower_cards.count).to eq(0)
  end

  it "add new brrowers and assigns it an id" do
    lib = Library.new(name: "Pritzker Law Library")
    borrower = BorrowerCard.new("Mike")
    lib.issues_borrower_card(borrower)
    expect(lib.borrower_cards.keys).to eq([1])
    expect(lib.borrower_cards.values).to eq([borrower])
  end

  it "add new books and assigns it an id" do
    lib = Library.new(name: "Pritzker Law Library")
    book = Book.new(title: "The Stranger", author: "Albert Camus")
    wrapper = LibraryWrapper.new(book)
    lib.register_new_book(wrapper)
    expect(lib.books.count).to eq(1)
    expect(lib.books.values[0]).to eq(wrapper)
  end

  it "allows a Borrower to check out a book by its id" do
    lib = Library.new(name: "Pritzker Law Library")
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    wrapper = LibraryWrapper.new(book)
    lib.register_new_book(wrapper)
    book_id = lib.books.keys[0]
    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]
    book = lib.check_out_book(book_id, borrower_id)

    expect(book.book).to be_a(Book)
    expect(book.book.title).to eq "Green Eggs and Ham"
    expect(book.status).to eq 'checked out'
  end

  it "knows who borrowed a book" do
    lib = Library.new(name: "Pritzker Law Library")
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    wrapper = LibraryWrapper.new(book)
    lib.register_new_book(wrapper)
    book_id = lib.books.keys[0]
    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]
    book = lib.check_out_book(book_id, borrower_id)

    expect( book.get_borrower ).to eq sam
  end

  it "does not allow a book to be checked out twice in a row" do
    lib = Library.new(name: "Pritzker Law Library")
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    wrapper = LibraryWrapper.new(book)
    lib.register_new_book(wrapper)
    book_id = lib.books.keys[0]
    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]
    nielsen = BorrowerCard.new('Leslie Nielsen')
    lib.issues_borrower_card(nielsen)
    borrower_id2 = lib.borrower_cards.keys[1]
    book = lib.check_out_book(book_id, borrower_id)

    book_again = lib.check_out_book(book_id, borrower_id2)
    expect(book_again).to eq("That book is currently unavailable. Would you like to place a hold?")
  end

  it "allows a Borrower to check a book back in" do
    lib = Library.new(name: "Pritzker Law Library")
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    wrapper = LibraryWrapper.new(book)
    lib.register_new_book(wrapper)
    book_id = lib.books.keys[0]
    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]
    book = lib.check_out_book(book_id, borrower_id)

    lib.check_in_book(book_id)
    expect(book.status).to eq 'available'
  end

  it "does not allow a Borrower to check out more than two Books at any given time" do
    # yeah it's a stingy library
    lib = Library.new(name: "Pritzker Law Library")
    
    book1 = Book.new(title: "Eloquent JavaScript")
    wrapper1 = LibraryWrapper.new(book1)
    book2 = Book.new(title: "Essential JavaScript Design Patterns")
    wrapper2 = LibraryWrapper.new(book2)
    book3 = Book.new(title: "Green Eggs and Ham")
    wrapper3 = LibraryWrapper.new(book3)    

    lib.register_new_book(wrapper1)
    lib.register_new_book(wrapper2)
    lib.register_new_book(wrapper3)

    book_id1 = lib.books.keys[0]
    book_id2 = lib.books.keys[1]
    book_id3 = lib.books.keys[2]

    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]
    
    # The first two books should check out fine
    book_js = lib.check_out_book(book_id1, borrower_id)
    expect(book_js.book.title).to eq "Eloquent JavaScript"

    book_ds = lib.check_out_book(book_id2, borrower_id)
    expect(book_ds.book.title).to eq "Essential JavaScript Design Patterns"

    # However, the third should return nil
    book_fail = lib.check_out_book(book_id3, borrower_id)
    
    expect(book_fail).to eq("Ineligible to borrow at this time.")
  end

  it "after a book is returned, it can be checked out again" do
    lib = Library.new(name: "Pritzker Law Library")
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    wrapper = LibraryWrapper.new(book)
    lib.register_new_book(wrapper)
    book_id = lib.books.keys[0]
    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]    
    nielsen = BorrowerCard.new('Leslie Nielsen')
    lib.issues_borrower_card(nielsen)
    borrower_id2 = lib.borrower_cards.keys[1]
    book = lib.check_out_book(book_id, borrower_id)
    lib.check_in_book(book_id)
    expect(book.status).to eq 'available'
    book = lib.check_out_book(book_id, borrower_id2)
    expect(book.status).to eq 'checked out'
    expect( book.get_borrower ).to eq nielsen
  end

  it "won't allow a borrower with an overdue book to check out a book" do
    lib = Library.new(name: "Pritzker Law Library")
    book1 = Book.new(title: "Eloquent JavaScript")
    wrapper1 = LibraryWrapper.new(book1)
    book2 = Book.new(title: "Essential JavaScript Design Patterns")
    wrapper2 = LibraryWrapper.new(book2)
    
    lib.register_new_book(wrapper1)
    lib.register_new_book(wrapper2)
    
    book_id1 = lib.books.keys[0]
    book_id2 = lib.books.keys[1]
    
    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]    
    
    book = lib.check_out_book(book_id1, borrower_id)
    Time.stub(:now).and_return(Time.parse("2014-10-10"))
    book = lib.check_out_book(book_id2, borrower_id)
    
    expect(book).to eq("Ineligible to borrow at this time.")
  end

  it "allows books to be put on hold and checks out immediately" do
    lib = Library.new(name: "Pritzker Law Library")
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    wrapper = LibraryWrapper.new(book)
    lib.register_new_book(wrapper)
    book_id = lib.books.keys[0]
    sam = BorrowerCard.new('Sam-I-am')
    lib.issues_borrower_card(sam)
    borrower_id = lib.borrower_cards.keys[0]    
    nielsen = BorrowerCard.new('Leslie Nielsen')
    lib.issues_borrower_card(nielsen)
    borrower_id2 = lib.borrower_cards.keys[1]
    book = lib.check_out_book(book_id, borrower_id)
    lib.put_on_hold(book_id, borrower_id2)
    lib.check_in_book(book_id)
    expect(book.status).to eq 'checked out'
    expect( book.get_borrower ).to eq nielsen    
  end
end

describe Review do
  before do
    $stdout = StringIO.new
  end
  
  it "exists attached to a book" do
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    sam = BorrowerCard.new("Sam-I-am")
    review = Review.new(stars: 5, review:"YAY")
    book.add_review(sam,review)
    expect( book.reviews.count ).to eq(1)
  end

  it "can print out the reviews" do
    book = Book.new(title: "Green Eggs and Ham", author: "Dr. Seuss")
    sam = BorrowerCard.new("Sam-I-am")
    review = Review.new(stars: 5, review:"YAY")
    book.add_review(sam,review)
    $stdout.should_receive(:puts).with("Sam-I-am gave Green Eggs and Ham 5 stars")
    $stdout.should_receive(:puts).with("Their review:")    
    $stdout.should_receive(:puts).with("YAY")    
    book.check_reviews
  end
end