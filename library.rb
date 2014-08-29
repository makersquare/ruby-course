class Book
  attr_reader :title, :author, :id
  attr_accessor :status

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
  end

  def status
    @status
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else 
      return false
    end
  end

  def check_in
    @status = 'available'
  end
end
  
class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name, :title, :author, :who_has_book
  attr_accessor :books, :id_num, :borrower

  def initialize(name)
    @name = name
    @borrower = Hash.new(0)
    @books = [ ]
    @id_num = 0
  end

  def register_new_book(title, author)
    @books.push(Book.new(title, author, (@id_num += 1)))
  end

  def check_out_book(book_id, borrower)
    @books.each do |b|
      if b.id == book_id && b.status == 'available'
        b.check_out
        @borrower[book_id] = borrower
        return b
      else
        return nil
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
