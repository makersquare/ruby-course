require 'spec_helper'

describe Library::BookRepo do
    
  def book_count(db)
    db.exec("SELECT COUNT(*) FROM books")[0]["count"].to_i
  end

  let(:db) { Library.create_db_connection('library_test') }

  before(:each) do
    Library.clear_db(db)
  end
  
  it "gets all books" do
    sql = %q[
      INSERT INTO books (title,author)
      VALUES ($1,$2);
    ]
    db.exec(sql, ["Alice in Wonderland","Lewis Carrol"])
    db.exec(sql, ['1984','George Orwell'])

    books = Library::BookRepo.all(db)
    expect(books).to be_a Array
    expect(books.count).to eq 2

    titles = books.map {|b| b['title'] }
    expect(titles).to include "Alice in Wonderland", "1984"
    authors = books.map {|b| b['author']}
    expect(authors).to include 'Lewis Carrol', 'George Orwell'
  end
  
  it "creates books" do
    expect(book_count(db)).to eq 0

    book = Library::BookRepo.save(db, { 'title' => "Alice in Wonderland", 'author' => 'Lewis Carrol' })
    expect(book['id']).to_not be_nil
    expect(book['title']).to eq "Alice in Wonderland"
    expect(book['author']).to eq 'Lewis Carrol'
    expect(book['status']).to eq 'available'
    expect(book['borrower']).to be_nil

    # Check for persistence
    expect(book_count(db)).to eq 1

    book = db.exec("SELECT * FROM books")[0]
    expect(book['id']).to_not be_nil
    expect(book['title']).to eq "Alice in Wonderland"
    expect(book['author']).to eq 'Lewis Carrol'
    expect(book['status']).to eq 'available'
    expect(book['borrower']).to be_nil
  end
  
  it 'checks books out' do
    book1 = Library::BookRepo.save(db, {'title' => '1984', 'author' => 'George Orwell'})
    user = Library::UserRepo.save(db, {'name' => 'Chriss'})
  
    book2 = Library::BookRepo.check_out(db,book1['id'],user['id'])
    expect(book2['status']).to eq 'checked out'
    expect(book2['borrower_id']).to eq(user['id'])
  end
  
  it 'only allows book to be checked out by one person at a time' do
    book = Library::BookRepo.save(db, {'title' => '1984', 'author' => 'George Orwell'})
    user1 = Library::UserRepo.save(db, {'name' => 'annabelle'})
    user2 = Library::UserRepo.save(db, {'name' => 'clairence'})
   
    check_out = Library::BookRepo.check_out(db,book['id'], user1['id'])
    check_out2 = Library::BookRepo.check_out(db, book['id'], user2['id'])
    expect(check_out2['borrower_id']).to eq(user1['id'])
  end
  
  it 'checks in a book' do
    book = Library::BookRepo.save(db, {'title' => 'Life of Pi', 'author' => 'Yann Martel'})
    user = Library::UserRepo.save(db, {'name' => 'Fat Richard'})
    
    Library::BookRepo.check_out(db, book['id'], user['id'])
    checkin = Library::BookRepo.check_in(db, book['id'])
    expect(checkin['status']).to eq 'available'
    expect(checkin['borrower_id']).to be_nil
  end
  
  it 'finds a book' do
    book = Library::BookRepo.save(db, {'title' => 'Life of Pi', 'author' => 'Yann Martel'})
    user = Library::UserRepo.save(db, {'name' => 'Fat Richard'}) 
  
    Library::BookRepo.check_out(db, book['id'], user['id'])
    book_data = Library::BookRepo.find(db, book['id'])
    expect(book_data).to be_a Hash
    expect(book_data['title']).to eq('Life of Pi')
    expect(book_data['authzor']).to eq('Yann Martel')
    expect(book_data['status']).to eq('checked out')
    expect(book_data['borrower_id']).to eq(user['id'])
  end
  
end