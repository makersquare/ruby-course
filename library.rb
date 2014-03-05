
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
  attr_accessor :book_count

  def initialize(name, book_count=0)
    @book_count = book_count
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

    book = books.find { |book| book.id == book_id  }

    if (book.status == "checked_out")
      return nil
    elsif (borrower.book_count > 0)
      return nil
    else
      book.status = "checked_out"
      book.borrower = borrower
      book.borrower.book_count += 1
    end
    return book
  end

  def get_borrower(book_id)
    book = books.find {|b| b.id == book_id}
    return book.borrower.name


  end

  def check_in_book(book)
    books.select do |b|
      if (b.borrower.name == book.borrower.name)
        b.status = "available"
        b.borrower = nil
      end
    end
  end

  def available_books
    books.select do |book|
      book.status == 'available'
    end
  end

  def borrowed_books
   borrowed_b = books.select {|book| book.status == "checked_out"}
end
end
