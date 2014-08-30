require 'pry-byebug'
class Book
  attr_reader :author, :title, :id, :status, :borrower, :year_published, :edition
  attr_accessor :review
  def initialize(title,author,year_published=1800,edition='1st')
    @author = author
    @title = title
    @id = nil
    @status = "available"
    @year_published = year_published
    @edition = edition
    @review = {}
  end

  def check_out
    return false if @status == "checked_out"
    @status = "checked_out" if @status == "available"

  end

  def check_in
    @status = "available" if @status == "checked_out"
  end

  def overdue?
  end

  def change_id(x)
    @id = x
  end

end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def leave_review
  end


end

class Library
  @@counter = 0 
  
  attr_reader :books, :name, :book_status
  def initialize(name="library")
    @name = name
    @books = []
    @book_status = {}  
  end

  def book_by_id
  end

  def books
    @books
  end

  def add_book

  end

  def check_out_book(book_id,borrower)
    @book_status[book_id.to_s][:book].check_out
    @book_status[book_id.to_s][:borrower] = borrower
    @book_status[book_id.to_s][:book] 
  end

  def get_borrower(book_id)
    @book_status[book_id.to_s][:borrower].name
  end

  def check_in_book
  end

  def available_books
  end

  def borrowed_books
  end

  def register_new_book(title,author)
    @@counter += 1
    a = Book.new(title,author)
    a.change_id(@@counter)
    @books.push(a)
    @book_status[@@counter.to_s]={book:a}
  end
end


# Create a Hash for borrowed books {:book_id => Borrower Name}
# Get rid of borrower in book attributes. Add something to Library to track the borrower. 
# User .count method of borrow hash to check the number of books checked out. 
