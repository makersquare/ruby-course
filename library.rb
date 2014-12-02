
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_accessor :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = 'available'
  end

  def check_out
    if (@status == 'available')
      @status = 'checked_out'
      return true
    else
      return false
    end
  end

  def check_in
    if (@status == 'checked_out')
      @status = 'available'
      return true
    else
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
attr_reader :books
attr_reader :name
attr_reader :next_id


  def initialize(name)
    @books = []
    @next_id = 1
    @borrowers = {}
    @name = name
    
  end

  def register_new_book(title, author)
      new_book = Book.new(title,author)
      new_book.id = @next_id
      @next_id += 1

      books.push(new_book)
  end

  def check_out_book(book_id, borrower)

    books.each do |book|
      if (book.id == book_id && book.status == 'available')
         @borrowers[:book_id] = borrower
         book.status = 'checked_out'
         return book
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
