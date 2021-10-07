class Api::V1::BooksController < ApplicationController

  def user_books
    require './app/dummys/book_dummy'

    user_id = params[:user_id]

    @answer = Answer.find_by(key: user_id)

    if @answer
      books_data = @answer[:save_data]
      book_keys = books_data.keys

      crown_list = {}

      q_id_list = {}

      book_keys.each do |book_key|
        crown = { gold: 0, silver: 0, bronze: 0 }

        u_keys = books_data[book_key][:units].keys

        u_keys.each do |u_key|
          crown_list[u_key] = books_data[book_key][:units][u_key][:crown]
          q_id_list[u_key] = books_data[book_key][:units][u_key][:latestQuestionID]
        end
      end

      dummy_books = call_books

      book_keys.each do |book_key|
        dummy_books.each_with_index do |dummy_book, index|
          if dummy_book[:drillid] == book_key
            units = dummy_book[:units]
            units.each_with_index do |unit, unit_index|

              if crown_list[unit[:id]]
                dummy_books[index][:units][unit_index][:crown] = crown_list[unit[:id]]
              end

              
              if q_id_list[unit[:id]]
                dummy_books[index][:units][unit_index][:latestQuestionID] = q_id_list[unit[:id]]
              end
            end
          end
        end
      end

      output = dummy_books

      render status: 200, json: output
    else

      output = call_books

      render status: 200, json: output
    end
  end
  
end
