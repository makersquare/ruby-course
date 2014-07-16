class Book
  attr_reader :title, :author
  attr_accessor :status, :borrower ,:id
  def initialize(title, author)
    @title=title
    @author=author
    @status="Available"
    @borrower=nil
    @id=nil
  end
  def check_out(borrower)
    if @status=="Available"
      @status="Checked Out"
      @borrower=borrower
      @borrow.books_lend.push()
    end
  end
  def check_in(borrower)
    if @status=="Checked Out"
      @status="Available"
      @borrower=nil
    end
  end
end

class Borrower
  attr_reader :name
  attr_accessor :books_lend
  def initialize (name)
    @name=name
    @books_lend=[]

  end
end

end

class Library
  def initialize
    @books=[]
  end

  def howmany
    return "The Library contains #{@books.length} books! Go get one!"
  end

  def add_book(title, author)
    nbook=Book.new(title, author)
    @books.push(nbook)
  end
end