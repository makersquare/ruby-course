
class Book
  attr_reader :author, :id
  attr_accessor :status, :borrower, :title

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = "available"
  end

  def check_out
    if (@status == "available")
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

  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library

  attr_reader :books

  def initialize(name)
    @books = []
  end

  # def books
  # end

  def add_book(title, author)
    books.push(Book.new(title, author, books.count))
  end

  def check_out_book(book_id, borrower)
      books.select do |book|

        if (book.id == book_id)
          if(book.status == 'checked_out')
              return nil
            else
              chosen_book = book
              book.status = 'checked_out'
              book.borrower = Borrower.new(borrower).name
            end
        end

        return chosen_book
      end
  end

  def get_borrower(book_id)
    books.select do |book|
      if book.id == book_id
        return book.borrower.name
      end
    end


  end

  def check_in_book(book)
    books.select do |b|
      if (b.borrower.name == book.borrower.name)
        b.status = "available"
      end
    end
  end

  def available_books
  end

  def borrowed_books
  end
end
