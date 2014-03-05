
class Book
  attr_reader :author
  attr_reader :title

  def initialize(title, author, status='available', borrowed_to='none')
    @title = title
    @author = author
    @status = status
  end

  def id
    nil
  end

  def status
    @status
  end

  def check_out
    if @status != "checked_out"
      @status = "checked_out"
      true
    else
      false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
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
  attr_accessor :books

  def initialize
    @books = []
    @id = 1
  end


  def add_book(title, author)
    @books << {"title" => "#{title}", "author" => "#{author}", "id" => @id}
    @id = @id+=1
  end

  def check_out_book(book_id, borrower)
    @books.each { |book|
        if book["id"] = book_id
            @check_title = book["title"]
            @check_author = book["author"]
        end }
    check_book = Book.new(@check_title, @check_author, "checked_out", borrower)
  end

  def get_borrower(book_id)

  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books

  end
end
