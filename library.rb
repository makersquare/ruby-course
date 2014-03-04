
class Book
  attr_reader :author
  attr_accessor :title
  attr_accessor :status
  attr_accessor :current_borrower


  def initialize(title="", author="", book_id = nil)
    @author = author
    @title = title
    @book_id = book_id
    @status = "available"
    @current_borrower = nil
  end

  def id
    @book_id
  end

  def id=(id)
    @book_id = id
  end


  def check_out(current_borrower=nil)
    if @status == "available"
      @status = "checked_out"
      @current_borrower = current_borrower
      return true
    else
      return false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
      return true
    else
      return false
    end
  end
end


class Borrower
  attr_accessor :name
  attr_accessor :has_this_book

  def initialize(name)
    @name = name
    @has_this_book = nil
  end


end

class Library
  attr_accessor :books
  attr_accessor :current_id


  def initialize
    @books = []
    @current_id = 1
  end

  def register_new_book(title, author)
    #create the new book
    new_book = Book.new(title, author, current_id)

    #increment @current_id
    @current_id = @current_id + 1

    #add it to the array
    @books << new_book

  end


  def find_by_id(book_id)   # Takes a book_id and returns the book object
    @books.each do |x|
      if x.id == book_id
        return x
      else
        puts "ID not found"
        return nil
      end
    end
  end




  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)

    # find the book with that id
    current_book = self.find_by_id(book_id)

    # if borrower doesn't already have a book out
    if (borrower.has_this_book == nil)

      #Check it out if it's available
      if current_book.check_out(borrower)
        borrower.has_this_book = book_id
        return current_book
      else
        return nil
      end
    else
      return nil
    end

  end

  def get_borrower(book_id)
    current_book = find_by_id(book_id)
    return current_book.current_borrower.name
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
