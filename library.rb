class Book
  attr_reader :author, :title, :id, :status
  attr_accessor :id, :borrower
  def initialize(title="", author="", id=nil)
    @title = title
    @author = author
    @id = id
    @status = "available"

  def title=(title)
    @title=title
  end

  def author=(author)
    author=author
  end

  def status=(status)
    @status=status
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

end
class Borrower
  attr_reader :name
  attr_accessor :book_count

  def initialize(name, book_count=0)
    @name = name
    @book_count = book_count
  end

  def name=(name)
    @name=name
  end


end

class Library
  attr_accessor :name
  attr_reader :books
  def initialize(name)
    @books = []
  end

  def books
    @books
  end


  def register_new_book(title, author)
    book = Book.new(title, author, id=books.count )
    @books.push(book)

  end

  def check_out_book(book_id, borrower)
    book = books.find {|bk| bk.id == book_id}
    if (book.status == "checked_out")
      return nil
    elsif (borrower.book_count > 0)
      return nil
    else
      book.status = 'checked_out'
      book.borrower = borrower
      borrower.book_count += 1
    end
    return book
  end

  def check_in_book(book)
    book = books.find{|bk| bk.borrower.name == book.borrower.name}
    book.status = 'available'


  end

  def available_books
    books.select {|bk| bk.status == 'available'}


  end

  def get_borrower(book_id)
    book = books.find {|bk| bk.id == book_id}
    return book.borrower.name
  end
  def borrowed_books
  end
end
