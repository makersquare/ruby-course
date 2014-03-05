class Book
  attr_reader :author, :title
  attr_accessor :status, :id, :borrower
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
  attr_accessor :name

  def initialize(name)
    @name = name
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

    @books.push(Book.new(title,author, books.count))
  end

  def check_out_book(book_id, borrower)
    books.select do |book|
       if (book.id = book_id)
          if (book.status == 'checked_out')
            return nil
          else
            chosen_book = book

            book.status = "checked_out"
            book.borrower =  borrower
          end
        end

        return chosen_book
    end
  end

  def get_borrower(book_id)
    books.select do |book|
      if book.id = book_id
        return book.borrower.name
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
