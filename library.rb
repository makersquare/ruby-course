
class Book

  attr_reader :author, :title, :id, :status

  attr_accessor :checked_out_to

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
    @checked_out_to = ''
  end

  def check_out
    if @status == 'checked_out'
       return false
    else
      @status = 'checked_out'
      true
    end
  end

  def check_in
    @status = 'available'
  end
end



class Borrower

  attr_reader :name

  def initialize(name)
    @name = name
  end
end




class Library

  def initialize
    @books = []
    @last_id = 0
    @borrower_hash = Hash.new([])
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @last_id =+ 1
    @books << Book.new(title, author, id=@last_id)

  end

  def check_out_book(book_id, borrower)
      if @books[book.id].check_out
        @borrower_hash[:borrower] << @books[book.id]
        return book
      end
    end
  end

  def get_borrower(book_id)
      @borrower_hash[@books[book.id] == b
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
