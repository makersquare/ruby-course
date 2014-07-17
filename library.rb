class Book
  attr_reader :author, :title
  attr_accessor :status, :id

  def initialize(title,author)
    @author = author
    @title=title
    @id=nil
    @status='available'

  end
  def check_out
    if @status=='available'
      @status="checked_out"
      true
    else false
    end
  end

  def check_in
    @status='available'
  end
end

class Borrower
  attr_accessor :name
  def initialize(name)
    @name=name
  end
end

class Library
  attr_reader :books
  def initialize
    @books=[]
    @id_count=0
    @borrowers={}
    
  end
  
  # def books
  # end

  def add_book(title, author)
    added=Book.new(title,author)
    @books.push(added)
    added.id=@id_count
    @id_count+=1
  end

  def check_out_book(book_id, borrower)
    book= @books.find { |book| book.id=book_id}
    # @books.each do |book|
    #   if book.id == book_id
    #     book.check_out
    #     return book
    #   end
    # end
   borrowed= @borrowers.group_by {|key, value| value }[borrower] || []
    if book.status == "available" && borrowed.length < 2
      book.check_out
      @borrowers[book_id] = borrower
    else
      return nil
    end
    book
  end

  def check_in_book(book)
  end
  def get_borrower(book_id)
    @borrowers[book_id].name
  end
  def available_books
    # @books.each do |book|
    #   if book.status=='available'
    #     puts book
    #   end
    # end
     @books.select { |book| book.status == "available" }
  end

  def borrowed_books
     @books.select{ |book| book.status == "checked_out"}
  end
end