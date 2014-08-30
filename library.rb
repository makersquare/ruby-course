require 'pry-byebug'
class Book
  attr_reader :author, :title, :id, :status, :borrower, :year_published, :edition
  def initialize(title,author,id=nil,year_published=1800,edition='1st')
    @author = author
    @title = title
    @id = id
    @status = "available"
    @year_published = year_published
    @edition = edition
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

end

class Borrower
  attr_reader 
  def initialize
  end

  def leave_review
  end


end

class Library
  attr_reader 
  def initialize
  end

  def books
    @books
  end

  def add_booky
  end

  def check_out_book
  end

  def get_borrower
  end

  def check_in_book
  end

  def available_books
  end

  def borrowed_books
  end
  def register_new_book
  end
end


# Create a Hash for borrowed books {:book_id => Borrower Name}
# Get rid of borrower in book attributes. Add something to Library to track the borrower. 
# User .count method of borrow hash to check the number of books checked out. 
