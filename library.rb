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
  attr_accessor :name, :current_books
  def initialize(name)
    @name=name
    current_books= []
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
    newbook= @books.find {|book| book.id == book_id}
    if @borrowers.select{|key, value| value == borrower}.size >=2
      return nil
    end
    if newbook.check_out
       @borrowers[book_id]= borrower
       newbook
    end
  end

  def check_in_book(book)
    book.status="available"
  end
  def get_borrower(book_id)
    @borrowers[book_id].name
  end
  def available_books
    @books.select { |book| book.status == "available" }
  end

  def borrowed_books
    @books.select{ |book| book.status == "checked_out"}
  end
end