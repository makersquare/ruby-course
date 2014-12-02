
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_accessor :status
  attr_accessor :borrower
  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
    @borrower = nil
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
    else
      puts "u can't"
    end
  end

  def check_in
    @status = 'available'
    @borrower = nil
  end
end

class Borrower
  attr_reader :name
  attr_accessor :books
  def initialize(name)
    @name = name
    @books = []
  end
end

class Library
  attr_reader :books
  attr_reader :name
  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(title, author)
    book = (Book.new(title, author))
    @books.push(book)
    book.id = @books.length
  end

  def check_out_book(book_id, borrower)
    @books.each {|book|
    if book.id == book_id
      if book.status == 'available' && borrower.books.length < 2
        book.check_out
        book.borrower = borrower
        borrower.books.push(book)
        return book
      else
      return nil
      end
    end
    } 
  end

  def get_borrower(book_id)
    @books.each {|book|
      if book.id == book_id
        borrower = book.borrower
        return borrower.name
      end
    }
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
    avail = []
    @books.each{|book|
      if book.status == 'available'
        avail.push(book)
      end
      }
      return avail
  end

  def borrowed_books
    borrowed = []
    @books.each{|book|
      if book.status == 'checked_out'
        borrowed.push(book)
      end
      }
      return borrowed
  end
end
