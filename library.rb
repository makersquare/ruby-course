
class Book
  @@id = 0
  attr_reader :author, :title, :id, :status

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
  end
  def set_id
    @id = @@id += 1
  end
  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else
      puts "That book is already checked out."
      return false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
      return true
    else
      puts "That book is already checked in."
      return false
    end
  end

end

class Borrower
  @@borrowers = []
  attr_reader :name, :borrowed_books
  def initialize(name)
    @name = name
    @borrowed_books = []
    @@borrowers << self
  end
  def self.all
    @@borrowers
  end
end

class Library
  attr_reader :books
  def initialize(name)
    @books = []
  end

  def register_new_book(title,author)
    new_book = Book.new(title, author)
    new_book.set_id
    @books.push(new_book)
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    book = @books.find {|book| book.id == book_id }
    if(book.status == 'available' && borrower.borrowed_books.count < 2)
      borrower.borrowed_books << book.id
      book.check_out
      return book
    else
      return nil
    end
  end

  def get_borrower(book_id)
    Borrower.all.each do |borrower|
      if (borrower.borrowed_books.include? book_id)
        return borrower.name
      end
    end
  end

  def check_in_book(book)
    get = get_borrower(book.id)
    borrower = Borrower.all.find {|b| b.name == get}
    borrower.borrowed_books.delete(book.id)
    book.check_in
  end

  def available_books
    @books.find_all {|book| book.status == 'available'}
  end

  def borrowed_books
    @books.find_all {|book| book.status == 'checked_out'}
  end
end
