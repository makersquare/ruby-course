
class Book
  attr_reader :author, :title
  attr_accessor :id, :status, :borrower

  def initialize(title, author, id: nil, status: 'available', borrower: 'none')
    @author = author
    @title = title
    @id = id
    @status = status
    @borrower = borrower
  end
  def check_out
    if @status == 'available'
      @status = 'checked out'
      return true
    else
      return false
    end
  end
  def check_in
    if @status == 'checked out'
      @status = 'available'
    end
  end
end

class Borrower
  attr_reader :name
  attr_accessor :books

  def initialize(name, books: 0)
    @name = name
    @books = books
  end

  def count
    if @books < 2
      @books += 1
    end
  end
end

class Library
  attr_reader :name
  attr_accessor :books

  def initialize(name)
    @name = name
    @books = []
  end

  def register_new_book(title, author)
    @books << Book.new(title, author)
    @books.each { |x| x.id = rand(1000) }
  end

  def add_book(title, author)
    @books << Book.new(title, author)
    @books.each { |x| x.id = rand(1000) }
  end

  def check_out_book(book_id, borrower)
    if borrower.books < 2
      borrower.count
      @books.each do |book|
        if book.id == book_id
          if book.check_out
            book.borrower = borrower.name
            return book
          end
        end
      end
    end
    nil
  end

  def get_borrower(book_id)
    @books.each do |book|
      if book.id == book_id
        return book.borrower
      end
    end
  end


  def check_in_book(book)
    book.check_in
    book.borrower = 'none'
  end

  def available_books
  end

  def borrowed_books
  end
end
