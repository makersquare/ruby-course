
class Book
  attr_reader :author, :title
  attr_accessor :status, :borrower, :id

  def initialize(title="default", author="default")
    @title = title
    @author = author
    @status = 'available'
    @id = nil
    @borrower =nil
  end

  def check_out(borrower)
    if @status == 'available'
      @status = 'checked_out'
      @borrower = borrower
    else
      false
    end
  end

  def check_in
    @status = 'available'
    @borrower = nil
  end
end

class Borrower
  attr_reader :name
  attr_accessor :books_borrowed
  def initialize(name)
    @name = name
    @books_borrowed = []
  end
end

class Library
  attr_reader :books
  def initialize
    @books = []
  end

  def books
    @books
  end

 def count
    @books.length
 end

  def add_book(title, author)
    new_book = Book.new(title, author)
    @books << new_book
    new_book.id = books.length - 1
  end


  def check_out_book(book_id, borrower)
    final_book = nil
    book = books[book_id]
        if book.status == "available"
          if borrower.books_borrowed.count <=0
            book.status = 'checked_out'
            book.borrower = borrower
            borrower.books_borrowed.push(book.title)
            final_book = book
          end
        end
        final_book
      end


  def get_borrower(book_id)
    books[book_id].borrower.name
  end

  def check_in_book(book)
    if book.status == "checked_out"
      book.status = "available"
      book.borrower = nil
    end
  end

  def available_books
    @books.select { |book| book.status == "available" }
  end

  def borrowed_books
    @books.select {|book| book.status == "checked_out"}
  end

end
