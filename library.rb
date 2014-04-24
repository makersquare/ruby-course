require 'pry-debugger'
class Book

  attr_reader :author, :title
  attr_accessor :status, :id, :borrower

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @status = "available"
    @borrower = nil
  end

  def check_out
    if @status == "checked_out"
      false
    else
      @status = "checked_out"
      true
    end
  end

  def check_in
     @status = "available"
  end

end

class Borrower
  attr_reader :name
  attr_accessor :books

  def initialize(name)
    @name = name
    @books = []
  end
end

class Library


  attr_accessor :books, :name, :id

  def initialize(name)
    @books = []
    @counter_id = 0

  end

  def register_new_book(book)
    @counter_id += 1
    book.id = @counter_id
    @books << book
  end

  def check_out_book(book_id, borrower)
    selected_book = @books.find {|book| book.id == book_id}

     if (selected_book && selected_book.status =="checked_out") || borrower.books.count > 1
      return nil
     end


    if selected_book && selected_book.status =="available"
        selected_book.borrower = borrower
        selected_book.status = "checked_out"
        borrower.books << selected_book
      return selected_book
    else
      return "sorry, there is no book by that name"
    end


  end

  def get_borrower(book_id)
    selected_book = @books.find {|book| book.id == book_id}

    the_borrower = selected_book.borrower if selected_book

    the_borrower.name if the_borrower
  end

  def check_in_book(book)

    if book && book.status =="checked_out"
       book.status = "available"

    end
  end

  def available_books

   avail_books = []

    @books.each do |book|
      if book.status == "available"
          avail_books << book
        end
      end
       avail_books
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
