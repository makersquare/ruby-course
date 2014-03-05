
class Book
  attr_reader :author, :title, :status
  attr_accessor :id

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
    @id = nil
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
    if @status == "checked_out"
    @status = "available"
  end
  end
end
#  END OF BOOK CLASS DEFINITION


class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library

  def initialize(name)
    @name = name
    @books = []
    @borr_books = {}
  end

  def books
    @books
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = rand(1..150)
    add_book(title, author)
    @books << new_book
  end

   def add_book(title, author)
   end

  def check_out_book(book_id, borrower)
    borr_names = @borr_books.values
    name_iter = 0

    borr_names.each do |patron|
      if borrower == patron
        name_iter += 1
      end
    end

    if name_iter >= 2
      return nil
    end

    @books.each do |book|
      if book.id == book_id
        if book.status == 'available'
          book.check_out
          @borr_books[book.id] = borrower
          return book
        end
      end
    end
    return nil
  end

  def get_borrower(book_id)
    @borr_books[book_id].name
  end

  def check_in_book(book)
    book.check_in
    books_out = @borr_books.keys

    books_out.each do |bookID|
      if book.id == bookID
        @borr_books.delete(bookID)
      end
    end

  end

  def available_books
    books_in = []

    @books.each do |book|
      if book.status == 'available'
        books_in << book
      end
    end

    return books_in
  end

  def borrowed_books
    books_out = []
    @books.each do |book|
      if book.status == "checked_out"
        books_out << book
      end
    end

    return books_out
  end

end
