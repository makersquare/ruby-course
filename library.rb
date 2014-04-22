require 'pry-debugger'
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_reader :status
  attr_accessor :borrower

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      true
    else
      false
    end
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  attr_reader :name
  attr_accessor :num_books
  def initialize(name)
    @name = name
    @num_books = 0
  end
end

class Library
  attr_reader :books
  attr_reader :count

  def initialize
    @books = []
    @count = @books.length
    @counter = 0
  end

  # def count
  #   return @books.length
  # end

  # def books
  #   return @books
  # end

  def register_new_book(book)
    @books << book
    book.id = @counter
    @counter += 1
  end

  def check_out_book(book_id, borrower)
    if borrower.num_books < 2
      @books.each do |book|
        if book.id == book_id
          if book.status == "checked_out"
            return nil
          else
            book.borrower = borrower.name
            borrower.num_books += 1
            book.check_out
            return book
          end
        end
      end
    else
      return nil
    end
  end

  def get_borrower(book_id)
    @books.each do |book|
      if book.id == book_id
        return book.borrower
      end
    end
  end

  def check_in_book(book)
    # book.getborrow.num_books -= 1
    book.check_in
  end

  def available_books
    books = []
    @books.each do |book|
      if book.status == "available"
        books << book
      end
    end

    return books
  end

  def borrowed_books
  end
end
