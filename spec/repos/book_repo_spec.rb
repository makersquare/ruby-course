require 'spec-helper'

describe Library::BookRepo do

  def book_count(db)
    db.exec("SELECT COUNT(*) FROM books")[0]["count"].to_i
  end

  let(:db) { LIbrary.create_db_connection('library_test')}

  before(:each) do
    Library.clear_db(db)
  end

  it 'gets all books' do

  db.exec("INSERT INTO books (title,author) VALUES ($1,$2)", ["Cujo","Stephen King"])
  db.exec("INSERT INTO books (title,author) VALUES ($1,$2)", ["1984","George Orwell"])

  books = Library::BookRepo.all(db)
  expect(books).to ba_a Array
  expect(books.count).to eq 2

  titles = users.map {|u| u['name']}
  expect(titles).to include "Cujo", "1984"

  authors
