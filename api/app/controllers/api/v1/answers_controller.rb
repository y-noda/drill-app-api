class Api::V1::AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    parameters = params[:session].to_unsafe_h  #後で strongparameterかましてto_hにする
    key = parameters[:userid]
    book_id = parameters[:workbookid].to_s.to_sym

    @answer = Answer.find_or_initialize_by(key: key)
    save_data = { data_per_book: {}, total_data: {} }

    if @answer.new_record? 
      save_data[:data_per_book][book_id] = [parameters]
      if @answer = Answer.create(key: key, answer: save_data)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end

    else

      if @answer[:answer][:data_per_book][book_id]  
        old_data = @answer[:answer][:data_per_book][book_id].dup
        new_data = old_data + [parameters]
        save_data[:data_per_book][book_id] = new_data
      else
        old_data = @answer[:answer][:data_per_book].dup
        save_data[:data_per_book] = old_data
        save_data[:data_per_book][book_id] = [parameters]
      end
        
      if @answer.update(key: key, answer: save_data)
        
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end

    end

  end

  def show 
    @answer = Answer.find_by(key: params[:id])
    if @answer 
      render status: 200, json: { answer: @answer.answer }
    else
      render status: 400, json: { answer: '失敗' }
    end
  end
end
