
class Book
  attr_reader :author
  attr_reader :title
  attr_reader :id
  attr_accessor :status
  @@book_id_count = 1

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = @@book_id_count
    @@book_id_count += 1
  end

  def check_out()
    if @status == "available"
      @status = "checked_out"
    else 
      return false
    end
  end

  def check_in()
    if @status == "checked_out"
      @status = "available"
    else 
      return false
    end
  end
end

class Borrower
  attr_reader :name
  attr_accessor :checked
  def initialize(name)
    @name = name
    @num_checked = 0
  end
end

class Library
  attr_reader :books
  attr_reader :name
  attr_reader :borrowers
  def initialize(name)
    @name = name
    @books = []
    @borrowers = {}
  end

  def register_new_book(title, author)
    book = Book.new(title, author)
    @books.push(book)
  end

  def check_out_book(book_id, borrower)
    checked = nil
    @books.each do |book|
      if book.id == book_id && book.status == "available" && borrower.num_checked.count <= 2
        book.check_out()
        @borrowers[book_id] = borrower
        borrower.num_checked +=1
        checked = book
      end
    end
    checked
  end

  def get_borrower(book_id)
    @borrowers[book_id].name
  end

  def check_in_book(book)
    book.check_in()
    @borrowers.delete(book.id)
  end

  def book
  end

  def add_book(title, author)
  end

  

  def available_books
  end

  def borrowed_books
  end
end
