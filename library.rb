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
    if @status='available'
      @status='checked_out'
    end
  end

  def check_in
    if @status=='available'
      return "Already Checked in!"
    else
      @status='available'
    end
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name=name
  end
end

class Library
  attr_reader :books
  def initialize
    @books=[]
    @id_count=0
    
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
    @books.each do |book|
      if book.id == book_id
        book.check_out
        return book
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