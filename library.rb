require 'csv'
# require 'win32console'

class Book

  attr_reader :author, :title, :id, :status, :edition, :year_published, :rating, :review

  @@num_books = 0 # for keeping track of ids

  def initialize(title="default_title", author ="default_author", id = nil, year_published = nil, edition = nil)
    @author = author
    @title = title
    @@num_books+=1
    @id = @@num_books
    @status = "available"
    @year_published = year_published
    @edition = edition
    @rating = nil
    @review = nil
  end

  def check_out
    if @status == "checked_out"
      false 
    else
      @status = "checked_out"
      true
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
      true 
    else
      @status = "checked_out"
      false
    end
  end

  def write_review(text)
    @review = text
  end

  def give_rating(rating)
    @rating = rating
  end

end

class Borrower

  attr_reader :name

  def initialize(name)
    @name = name
  end

end

class Library
  attr_reader :books, :name, :borrowers

  def initialize(name="Library of Alexandria")
    @name = name
    @books = []
    @borrowers = Hash.new()
      #key is borrower instance
      #values are arrays of book_ids
      #ex. {Borrower.new("Mike")=>[1,3], Borrower.new("Sara")=>[2,5]}
    end

    def register_new_book(book)
      @books << book
    end

    def check_out_book(book_id, borrower)
      book_to_checkout = @books.find {|x| x.id == book_id}
      if book_to_checkout.status == "checked_out"
        return nil
      else
        if @borrowers[borrower] == nil
          num_books_borrowed = 0
        else
          num_books_borrowed = @borrowers[borrower].count
        end

        if num_books_borrowed > 1 
          return nil
        else
          if @borrowers[borrower] == nil
            @borrowers[borrower] = []
            @borrowers[borrower] << book_id
          else
            @borrowers[borrower] << book_id
          end
          book_to_checkout.check_out
          return book_to_checkout
        end
      end
    end

    def get_borrower(search_id)
    # return @borrowers[book_id-1].name
    @borrowers.each do |borrower, book_ids|
      book_ids.each do |book_id|
        if book_id == search_id
          return borrower
        end
      end
    end

  end

  def check_in_book(book)
    book.check_in
    @borrowers[get_borrower(book.id)].delete(book.id)
  end

  def available_books
    @books.select {|x| x.status == "available"}
  end

  def borrowed_books
    books_borrowed = @books.select {|x| x.status == "checked_out"}
  end

  def register_books_from_csv(filepath)
    CSV.foreach(filepath) do |row|
      register_new_book(row[0],row[1])
    end
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "================"
      puts "Book ##{index+1}"
      puts "================"
      puts "ID: #{book.id}"
      puts "Status: #{book.status}"
      puts "Title: #{book.title}"
      puts "Author: #{book.author}"
      puts "Edition: #{book.edition}"
      puts "Year: #{book.year_published}"
      puts "Rating: #{book.rating}"
      puts "Review: #{book.review}"
    end
  end
end
