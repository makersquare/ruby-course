
class Book
  attr_accessor :status, :borrower
  attr_reader :author, :title, :id

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
    @borrower = nil
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
    end
  end
end


class Borrower
  attr_reader :name 
  attr_accessor :books_borrowed

  def initialize(name)
    @name = name
    @books_borrowed = 0
  end
end


class Library
  attr_reader :books, :book_id, :available_books, :borrowed_books

  def initialize
    @books = []
    @book_id = 100
  end

  def count
    @books.length
  end

  # def books
  # end

  def register_new_book(title, author)
    @books <<  Book.new(title, author, @book_id)
    @book_id += 1
  end

  def check_out_book(book_id, borrower)
    if borrower.books_borrowed < 3
      # look up a method called 'select'. Sometimes the method 'find' is better.
      @books.each do |book|
        if book.id == book_id && book.status == 'available'
          book.status = 'checked_out'
          book.borrower = borrower
          borrower.books_borrowed += 1
          return book
        else
          return nil
        end
      end 
    end
  end

  def get_borrower(book_id)
    @books.each do |book|
      if book.id == book_id
        return book.borrower.name
      end
    end 
  end

  def check_in_book(book)
    if book.status == 'checked_out'
      book.status = 'available'
      book.borrower = nil
    end
  end

  def available_books
    @books.select { |book| book if book.status == 'available' }
  end

  def borrowed_books
    @books.select { |book| book if book.status == 'checked_out' }
  end
end
