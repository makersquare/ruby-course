class Book
  attr_accessor :title, :author, :id, :status
  attr_accessor :borrower, :year, :edition, :rating, :opinion
  def initialize(title, author, year, edition)
    @title = title
    @author = author
    @status = "available"
    @year = year
    @edition = edition
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
attr_accessor :name, :book_count, :give_review
  def initialize(name)
    @name = name
    @book_count = 0
  end

  def give_review(rating, opinion = nil, book)
    if rating >= 0 && rating <= 10
      book.rating = rating
      book.opinion = opinion
      return book
    else
      return "please rate between 0 and 10"
    end
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

  def register_new_book(title, author, year, edition)
    new_book = Book.new(title,author, year, edition)
    @books << new_book

    new_book.id = @id_counter
    @id_counter += 1
  end

  def check_out_book(book_id, borrower)
    # return a book
    @books.each do |book|
      if borrower.book_count < 2  # why <= 2 doesn't work?
        if book.id == book_id && book.status == "available"
          book.status = "checked_out"
          book.borrower = borrower
          borrower.book_count += 1
          return book
        end
      end
    end
    nil
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

  def available_books
    @books.select do |book|
      book.status == "available"
    end
  end

  # def available_books
  #   available_book_list = []  #this was new
  #   @books.each do |book|
  #     if book.status === "available"
  #       # available_book_list = []
  #       available_book_list << book
  #       # return available_book_list
  #     end
  #   end
  #   return available_book_list #this was new
  # end


  def borrowed_books
    borrowed_books_list = []
    @books.each do |book|
      if book.status == "checked_out"
        borrowed_books_list << book
      end
    end
    return borrowed_books_list
  end


  # def borrowed_books # why does this return 3 w/count?
  #   borrowed_books_list = []
  #   @books.each do |book|
  #     if book.status == "checked_out"
  #       borrowed_books_list << book
  #       borrowed_books_list
  #     end
  #   end
  # end

end
