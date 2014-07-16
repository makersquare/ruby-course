class Library
  attr_accessor :books, :borrowed_books
  def initialize(args = {})
    @books = args[:books] || []
    @borrowed_books = {}
  end

  def available_books
    books.select {|book| book.status == 'available'}
  end

  def register_new_book(title, author)
    id = []
    9.times {id << rand(1..9)}
    books << Book.new(title: title, author: author, id: id.join)
  end

  def check_out_book(book_id, borrower)
    selected_book = books.select {|book| book_id == book.id}.pop
    return nil if borrowed_books.keys.include?(selected_book)
    return nil if borrowed_books.values.count(borrower) >= 2
    selected_book.check_out
    borrowed_books[selected_book] = borrower
    selected_book
  end

  def check_in_book(book)
    borrowed_books.delete(book)
    book.check_in
  end

  def get_borrower(book_id)
    selected_book = books.select {|book| book_id == book.id}.pop
    borrowed_books[selected_book].name
  end

end

class Book
  attr_accessor :status
  attr_reader :title, :author, :id
  def initialize(args = {})
    @status = 'available'
    @author = args[:author]
    @title = args[:title]
    @id = args[:id] || nil
  end

  def check_out
    @status == 'available' ? (@status = 'checked_out'; true) : false
  end

  def check_in
    @status = 'available'
  end
end

class Borrower
  attr_reader :name
  def initialize(args = {})
    @name = args[:name]
  end
end
