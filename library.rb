##require 'csv'

class Book
  attr_reader :author
  attr_accessor :title, :status, :current_borrower, :id, :year_published, :edition
  attr_accessor :ratings, :reviews

  def initialize(title="", author="", id = nil)
    @author = author
    @title = title
    @id = id
    @status = "available"
    @current_borrower = nil
    @year_published = ""
    @edition = ""
    @ratings = []
    @reviews = []
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
      @current_borrower = nil
      return true
    else
      return false
    end
  end
end


class Borrower
  attr_accessor :name, :has_this_book

  def initialize(name)
    @name = name
    @has_this_book = []
  end

  def leave_review(book, rating, review=nil)
    book.ratings << rating
    if review
      book.reviews << review
    end
  end





end

class Library
  attr_accessor :books, :current_id, :available_books, :borrowed_books

  def initialize
    @books = []
    @current_id = 1
    @available_books = []
    @borrowed_books = []
  end

  def register_new_book(title, author)
    #create the new book
    new_book = Book.new(title, author, current_id)

    #increment @current_id
    @current_id = @current_id + 1

    #add it to the arrays
    @books << new_book
    @available_books << new_book
    puts @available_books
  end


  def find_by_id(book_id)   # Takes a book_id and returns the book object
    @books.each do |x|
      if x.id == book_id
        return x
      end
    end
    return nil
  end

  def check_out_book(book_id, borrower)

    # find the book with that id
    current_book = self.find_by_id(book_id)

    # if borrower doesn't already have 2 books out
    if (borrower.has_this_book.count < 2)


      # If checkout is successful...
      if current_book.check_out(borrower)

        # Update the borrower's has_this_book status
        borrower.has_this_book << book_id

        # Update our own arrays and return the book
        @available_books.delete(current_book)
        @borrowed_books << current_book
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
    book.current_borrower.has_this_book.delete(book.id)
    book.check_in
    @borrowed_books.delete(book)
    @available_books << book
  end

  def import_by_csv(csv)
    lines=IO.readlines(csv)
    lines.each { |line|
      line.chomp!   #Get rid of \n character
      split_line = line.split(',')  #split line into array
      self.register_new_book(split_line[0].strip, split_line[1].strip)
    }



  end

end
