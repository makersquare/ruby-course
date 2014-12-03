
class Book
  attr_reader :author, :title, :status, :id

  AVAIL = "available"
  CHOUT = "checked_out"

  def initialize(title, author)
    @author = author
    @title = title
    @id = nil
    @status = AVAIL
  end

  def title
    @title
  end

  def check_out
    if(@status == AVAIL) 
      @status = CHOUT
    else 
      return false
    end
    return true
  end

  def check_in
    if(@status == CHOUT) 
      @status = AVAIL
      return @id
    else 
      return nil
    end
  end

  def set_id(id)
    @id = id
  end
end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  def initialize(name)
    # @members [
    #   {
    #     :borrower => Borrower
    #     :checked_out => Book[]
    #   }
    # ]
    @books = []
    @members = []
  end

  def books
    @books
  end

  def members
    @members
  end

  def add_book(title, author)
    book = Book.new(title, author)
    self.add_book = book
  end

  def add_book=(book)
    book.set_id(@books.length)
    @books.push(book)
  end

  def check_out_book(book_id, borrower)
    # Check if Borrower Exists
    
    if(!book = @books[book_id])
      # Book Does not Exist
      return nil
    end

    if (!member_id = @members.find_index { |member| member[:borrower] == borrower })
      # Create New Member Index
      member_id = @members.length
      new_member = { :borrower => borrower, :checked_out => []}
      @members.push(new_member)
    end

    # Each lib member can only checkout two books && Book is Available for Checkout
    if (@members[member_id][:checked_out].length < 2 && @books[book_id].check_out)
      @members[member_id][:checked_out].push(book)
      return book
    end
  end

  def check_in_book(book)
    # Check if book exists
    if (@books.include?(book))
      book_id = book.check_in
      member_id = @members.find_index { |member| member[:checked_out].include?(book) }
      return @members[member_id][:checked_out].delete(book)
    end
  end

  def available_books
    @books.select { |book| book.status == "available"}
  end

  def borrowed_books
    @books.select { |book| book.status == "checked_out"}
  end

  def get_borrower(book_id)
    book = @books[book_id]
    if (member_id = @members.find_index { |member| member[:checked_out].include?(book) })
      return @members[member_id][:borrower].name
    end
    return nil
  end

  def members_borrowed_books(borrower)
    if (member_id = @members.find_index { |member| member[:borrower] == borrower })
      return @members[member_id][:checked_out]
    end
    return nil
  end

end
