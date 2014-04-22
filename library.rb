
class Book
  attr_accessor :author, :title, :id, :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = nil
  end

  def check_out
    if @status == 'checked_out'
      false
    else
      @status = 'checked_out'
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
    end
  end
end

class Borrower
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books, :borrowers

  def initialize(name)
    @books = []
    @borrowers = {}
  end

  def register_new_book(book)
    book.id = rand()
    @books << book
  end

  def check_out_book(book, borrower)
    check_out_count = 0
    # Count how many times a borrower's name appears in the borrowers hash. If more than 2, no more books can be borrowed
    @borrowers.each do |key,value|
      if value == borrower.name
        check_out_count += 1
      end
    end

    # If less than 2 books have been checked out by the borrower and the book is available, book can be checked out
    if check_out_count < 2
      if book.status == 'available'
        book.status = 'checked_out'
        @borrowers[book.title] = borrower.name
        return book
      end
    end
  end

  def get_borrower(book)
    @borrowers[book.title]
  end

  def check_in_book(book)
    @borrowers.delete(book.title)
    book.status = 'available'
  end

  def available_books
  end

  def borrowed_books
  end
end
