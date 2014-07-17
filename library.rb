
class Book
  attr_reader :title, :author, :id, :status

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else
      return false
    end
  end

  def check_in
    if @status == 'checked_out'
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
  attr_reader :books, :name, :id
  def initialize
    @id_tab = 0
    @books = []
    @borrowers = {}
    @books_checked = {}
    @names = []
  end

  def register_new_book(title, author, id=@id_tab)
    @books << Book.new(title, author, id)
    @id_tab += 1
  end

  def check_out_book(book_id, borrower, count=0)
    pointer = 0
    @names.select { |name| pointer += 1 if name == borrower.name }
    book = @books.find { |book| book.id == book_id }
    if(book.status == 'available' && pointer < 2)
      @borrowers[borrower.name] = book
      @names << borrower.name
      book.check_out
      book
    else
      return nil
    end
  end





    # return nil if @books[book_id].status == 'checked_out'
    # @pointer = 0
    # @names.select do |name|
    #   @pointer += 1 if name == borrower.name
    # end
    # if @pointer < 2
      
    #   @books[book_id].check_out
    #   @books_checked[book_id] = borrower.name
    #   @borrowers[borrower.name] = @books[book_id]
    # else
    #   return nil
    # end


  def get_borrower(book_id)
    @borrowers.key(@books[book_id])
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
    @books.select { |book| book.status == 'available'}
    
  end

  def borrowed_books
    @books.select { |book| book.status == 'checked_out'}
  end
end
