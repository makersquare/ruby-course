require 'spec_helper'
require 'pg'

describe Library::BookRepo do

  def book_count(db)
    db.exec("SELECT COUNT(*) FROM books")[0]["count"].to_i
  end

  def checkout_count(db)
    db.exec("SELECT COUNT(*) FROM checkouts")[0]["count"].to_i
  end

  # A let(:db) define means you can use db in an it statement below
  # Also, the code in {} does not run until it sees a 'db' statement in an 'it' block
  # Therefore, the code will run for each 'it' block
  let(:db) {
    Library.create_db('library_test')
    Library.create_db_connection('library_test')
  }

  # Before each 'it' block we are clearing the data base
  # That way when we crete users we know exactly how many should be in the db
  before(:each) do
    Library.clear_db(db)
    Library.create_tables(db)
  end

  it "gets all books" do
    db.exec("INSERT INTO books (title, author) VALUES ($1, $2)", ["Alice's Adventures in Wonderland", "Lewis Carrol"])
    db.exec("INSERT INTO books (title, author) VALUES ($1, $2)", ["The Prophet", "Kahlil Gibran"])

    books = Library::BookRepo.all(db)
    expect(books).to be_a Array
    expect(books.count).to eq 2

    titles = books.map {|u| u['title'] }
    expect(titles).to include "Alice's Adventures in Wonderland", "The Prophet"
  end

  xit "creates books" do
    expect(book_count(db)).to eq 0
    expect(checkout_count(db)).to eq 0

    book = Library::UserRepo.save(db, { 'title' => "Alice's Adventures in Wonderland", 'author' => "Lewis Carrol" })
    expect(book['id']).to_not be_nil
    expect(book['title']).to eq "Alice's Adventures in Wonderland"
    expect(book['author']).to eq "Lewis Carol"
    expect(book['status']).to eq "available"

    # Check for persistence
    expect(book_count(db)).to eq 1
    expect(checkout_count(db)).to eq 1

    book = db.exec("SELECT * FROM users")[0]
    expect(book['title']).to eq "Alice's Adventures in Wonderland"
  end

  xit "finds books" do
    book = Library::BookRepo.save(db, { 'title' => "Alice's Adventures in Wonderland", 'author' => "Lewis Carrol" })
    retrieved_book = Library::BookRepo.find(db, book['id'])
    expect(retrieved_book['title']).to eq "Alice's Adventures in Wonderland"
  end

  xit "updates books" do
    book1 = Library::BookRepo.save(db, { 'title' => "Alice's Adventures in Wonderland", 'author' => "Lewis Carrol" })
    book2 = Library::BookRepo.save(db, { 'id' => user1['id'], 'name' => "Alicia's Adventures in Wonderland", 'author' => "Louis CK" })
    expect(book2['id']).to eq(book1['id'])
    expect(book2['title']).to include "Alicia"

    # Check for persistence
    user3 = Library::BookRepo.find(db, book1['id'])
    expect(user3['title']).to include "Alicia"
  end

  xit "check-out books" do
    book = Library::BookRepo.save(db, { 'title' => "Alice's Adventures in Wonderland", 'author' => "Lewis Carrol" })
    user = Library::UserRepo.save(db, { 'name' => "Alice" })

    # Checkout Book and Check Book Status
    book = book.checkout(db, book['id'], user['id'])
    expect(book['status'].to eq('checked_out'))

    # Check Checkouts Table Status from book_id
    checkout = Library::BookRepo.get_history(db, { 'book_id' => book['id'] })[0]
    expect(checkout['status'].to eq('checked_out'))

    # Check Checkouts Table Status from user_id
    checkout_log = Library::BookRepo.get_history(db, { 'user_id' => user['id'] })[0]
    expect(checkout_log['status'].to eq('checked_out'))
    expect(checkout_log['book_id'].to eq(book['id']))
    expect(checkout_log['user_id'].to eq(user['id']))
  end

  xit "check-in books" do
    book = Library::BookRepo.save(db, { 'title' => "Alice's Adventures in Wonderland", 'author' => "Lewis Carrol" })
    user = Library::UserRepo.save(db, { 'name' => "Alice" })

    # Check-out Book and Check-In Book
    book = book.checkout(db, book['id'], user['id'])
    book = book.checkin(db, book['id'])

    checkout = Library::BookRepo.get_history(db, { 'user_id' => user['id'] })[0]
    expect(checkout_log['status'].to eq('returned'))
    expect(checkout_log['book_id'].to eq(book['id']))
    expect(checkout_log['user_id'].to eq(user['id']))

  end

  xit "lose books" do
    book = Library::BookRepo.save(db, { 'title' => "Alice's Adventures in Wonderland", 'author' => "Lewis Carrol" })
    expect(book_count(db)).to eq 1

    Library::BookRepo.lose(db, book['id'])
    expect(book_count(db)).to eq 0
  end
end
