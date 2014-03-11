class Book
attr_accessor :title, :author, :id, :status
attr_accessor :borrower
  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
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

class Borrower
attr_accessor :name, :book_count
  def initialize(name)
    @name = name
    @book_count = 0
  end

end

class Library
attr_accessor :name, :books, :title, :author
attr_accessor :id  # not book object
  def initialize(name)
    @name = name
    @books = []
    @id_counter = 1
  end

  def register_new_book(title, author)
    new_book = Book.new(title,author)
    @books << new_book

    new_book.id = @id_counter
    @id_counter += 1
  end

  def check_out_book(book_id, borrower)
    # return a book
    @books.each do |book|
      if borrower.book_count < 2
        if book.id == book_id && book.status == "available"
          book.status = "checked_out"
          book.borrower = borrower
          borrower.book_count += 1
          return book
        end
      # else
      #   return nil
      end
    end

    nil

    #   if book.id == book_id && book.status == "available"

    #     if borrower.book_count <= 2
    #       # binding.pry
    #       book.status = "checked_out"
    #       book.borrower = borrower
    #       borrower.book_count += 1
    #       return book
    #     end

    #   else
    #     return nil
    #   end

    # end

  end

  def get_borrower(book_id)
    @books.each do |book|
      if book.id == book_id
        return book.borrower.name
      end
    end
  end

  def check_in_book(book)
    @books.each do |book_instance|
      if book_instance == book
        book_instance.status = "available"
        return book_instance
      end
    end
  end


end
