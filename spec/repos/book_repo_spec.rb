require 'spec_helper'

describe Library::BookRepo do

  def book_count(db)
    db.exec("SELECT COUNT(*) FROM books")[0]['count'].to_i
  end

  let(:db) { Library.create_db_connection('library_test') }

  before(:each) do
    Library.clear_db(db)
  end

    it "gets all books" do
      db.exec("INSERT INTO books (title, author) VALUES ($1, $2)", ["Oryx and Krake", "Margaret Atwood"])
      db.exec("INSERT INTO books (title, author) VALUES ($1, $2)", ["Station Eleven", "Emily Mandel"])

      books = Library::BookRepo.all(db)
      expect(books).to be_a Array
      expect(books.count).to eq 2

      authors = books.map {|u| u['author'] }
      expect(authors).to include "Margaret Atwood", "Emily Mandel"
    end

    it "creates books" do
      expect(book_count(db)).to eq 0

      book = Library::BookRepo.save(db, { 'title' => 'Good Omens', 'author' => 'Neil Gaiman' })
      expect(book['id']).to_not be_nil
      expect(book['title']).to eq "Good Omens"
      expect(book['author']).to eq "Neil Gaiman"

      # Check for persistence
      expect(book_count(db)).to eq 1

      book = db.exec("SELECT * FROM books")[0]
      expect(book['title']).to eq "Good Omens"
      expect(book['author']).to eq "Neil Gaiman"
    end

    it "finds users" do
      book = Library::BookRepo.save(db, { 'title' => 'Good Omens', 'author' => 'Neil Gaiman' })
      retrieved_book = Library::BookRepo.find(db, book['id'])
      expect(retrieved_book['title']).to eq "Good Omens"
      expect(retrieved_book['author']).to eq "Neil Gaiman"
    end

    it "updates users" do
      book1 = Library::BookRepo.save(db, { 'title' => 'Good Omens', 'author' => 'Neil Gaiman' })
      book2 = Library::BookRepo.save(db, { 'id' => book1['id'], 'author' => 'Neil Gaiman and Terry Pratchett' })
      expect(book2['id']).to eq(book1['id'])
      expect(book2['author']).to eq "Neil Gaiman and Terry Pratchett"

    # Check for persistence
      book3 = Library::BookRepo.find(db, book1['id'])
      expect(book3['author']).to eq "Neil Gaiman and Terry Pratchett"
  end
end