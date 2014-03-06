
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_reader :status
  attr_accessor :theguysnamewhoreadsforfree

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      return true
    else
      return false
    end
  end

  def check_in
    @status = "available"
  end

end



class Borrower
  attr_accessor :name
  attr_accessor :bookcount

  def initialize(name)
      @name = name
      @bookcount = 0
  end

end

class Library
  attr_reader :books
  attr_reader :count
  attr_accessor :id

  def initialize(name)
    @books = []
    @count = @books
    @id_counter = 0
  end

  def register_new_book(title, author)
    newbook = Book.new(title, author)
    newbook.id = @id_counter
    @id_counter += 1

    @books << newbook


  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    thisbook = @books[book_id]
    if (thisbook.status == "available") && (borrower.bookcount < 3)
      thisbook.check_out
      thisbook.theguysnamewhoreadsforfree = borrower
      borrower.bookcount += 1
      return thisbook
    else
      return nil
    end

  end

  def get_borrower(book_id)
    @books.each do | x |
      if x.id == book_id
        return x.theguysnamewhoreadsforfree.name
      else
        return "not possible EVER"
      end
    end
  end


  def check_in_book(book)
    book.check_in
  end

  def available_books
  end

  def borrowed_books
  end
end
