
class Book
  attr_reader :author, :title
  attr_accessor :id, :status, :borrower

  def initialize(title, author, id: nil, status: 'available')
    @author = author
    @title = title
    @id = id
    @status = status
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

  def initialize(name)
    @name = name
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
    @books.each do |book|
      if book.id == book_id
        book.check_out
        book.borrower = borrower.name
      end
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
  end

  def available_books
  end

  def borrowed_books
  end
end
