class Api::V1::AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    parameters = params[:session].to_unsafe_h  #後で strongparameterかましてto_hにする
    key = parameters[:userid]
    book_id = parameters[:workbookid].to_s.to_sym

    @answer = Answer.find_or_initialize_by(key: key)
    
    if @answer.new_record? 
      input_data = { data_per_book: {}, total_data: {} }
      input_data[:data_per_book][book_id] = [parameters]
      if @answer = Answer.create(key: key, save_data: input_data)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    else
      if @answer[:save_data][:data_per_book][book_id]  
        input_data = Marshal.load(Marshal.dump(@answer[:save_data]))
        input_data[:data_per_book][book_id].push(parameters)
      else
        input_data = Marshal.load(Marshal.dump(@answer[:save_data]))
        input_data[:data_per_book][book_id] = [parameters]
      end
        
      if @answer.update(key: key, save_data: input_data)
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
