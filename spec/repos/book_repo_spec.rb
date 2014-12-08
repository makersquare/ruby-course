require 'spec_helper'
require "./lib/library_plus/user_repo"

describe Library::BookRepo do

  def book_count(db)
    db.exec("SELECT COUNT(*) FROM books")[0]["count"].to_i
  end

  let(:db) { Library.create_db_connection('library_test') }

  before(:each) do
    Library.clear_db(db)
  end

  it "gets all books" do
    db.exec("INSERT INTO books (title, author) VALUES ($1, $2)", ["To Kill a Mockingbird", "Harper Lee"])
    db.exec("INSERT INTO books (title, author) VALUES ($1, $2)", ["Fellowship of the Ring", "J.R.R. Tolkien"])

    books = Library::BookRepo.all(db)
    expect(books).to be_a Array
    expect(books.count).to eq 2

    books = books.map {|u| u['title']}
    expect(books).to include "To Kill a Mockingbird", "Fellowship of the Ring"
  end

  it "creates books" do
    expect(book_count(db)).to eq 0

    book = Library::BookRepo.save(db, :title => "To Kill a Mockingbird", :author => "Harper Lee")
    expect(book['id']).to_not be_nil
    expect(book['title']).to eq "To Kill a Mockingbird"
    expect(book["author"]).to eq "Harper Lee"

    # Check for persistence
    expect(book_count(db)).to eq 1

    book = db.exec("SELECT * FROM books")[0]
    expect(book['title']).to eq "To Kill a Mockingbird"
  end

  it "finds books" do
    book = Library::BookRepo.save(db, :title => "To Kill a Mockingbird", :author => "Harper Lee")
    retrieved_book = Library::BookRepo.find(db, book['id'])
    expect(retrieved_book['title']).to eq "To Kill a Mockingbird"
    expect(retrieved_book["author"]).to eq "Harper Lee"
  end

  it "updates books" do
    book1 = Library::BookRepo.save(db, :title => "To Kill a Raven", :author => "Harper Lee")
    book2 = Library::BookRepo.save(db, { :id => book1['id'], :title => "To Kill a Mockingbird", :author => book1["author"] })
    
    expect(book2['id']).to eq(book1['id'])
    expect(book2['title']).to eq "To Kill a Mockingbird"

    # Check for persistence
    book3 = Library::BookRepo.find(db, book1['id'])
    expect(book3['title']).to eq "To Kill a Mockingbird"
  end

  it "destroys books" do
    book = Library::BookRepo.save(db, :title => "To Kill a Mockingbird", :author => "Harper Lee")
    expect(book_count(db)).to eq 1

    Library::BookRepo.destroy(db, book['id'])
    expect(book_count(db)).to eq 0
  end

  it "checks out books" do
    user = Library::UserRepo.save(db, :name => "Alice") 
    book = Library::BookRepo.save(db, :title => "Foundation", :author => "Isaac Asimov")

    checkout = Library::BookRepo.check_out(db, :book_id => book['id'], :user_id => user["id"])
    expect(checkout["user_id"]).to_not be_nil
    expect(checkout["book_id"]).to_not be_nil
  end
end
