
class Book
  attr_accessor :id
  attr_reader :author, :title, :status

  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
  end

  def check_out()
      if @status == "available"
        @status =  'checked_out'
        return true
    elsif @status ==  'checked_out'
      return false
    end
  end
  def check_in()
      if @status == "checked_out"
        @status =  'available'
        return true
    elsif @status ==  'available'
      return false
    end
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name, :books, :borrowed_books

  def initialize(name)
    @name = name
    @books = []
    @borrowed_books = []
    @borrower = {}


  end

  def add_book(title, author)
    b = Book.new(title, author)
    b.id = b.hash()
    @books.push(b)
  end

  def check_out_book(book_id, borrower)
    book = find_book_by_id(book_id)
    has_oustanding = find_book_by_borrower(borrower)
    if book != nil && book.status == 'available' && !(has_oustanding)
      borrowed_books.push(book)
      @borrower[book_id] = borrower
      book.check_out
      return book
    else
      return nil
    end
  end
  def find_book_by_id(book_id)
    @books.each do |book|
      if book.id = book_id
        return book
      end
    end
  end
  def check_in_book(book)
    @borrowed_books.delete(book.id)
    @borrower.delete(book.id)
    book.check_in()

  end
  def find_book_by_borrower(borrower)
    @borrower.each do |id, the_borrower|
      if the_borrower == borrower
        return find_book_by_id(id)
      end
    end
    return false
  end
  def available_books
    availables = []
    @books.each do |b|
      if !@borrowed_books.include? b
        availables.push(b)
      end
    end
    return availables
  end
  def get_borrower(book_id)
    return @borrower[book_id]
  end
end
