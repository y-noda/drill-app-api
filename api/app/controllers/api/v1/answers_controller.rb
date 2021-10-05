class Api::V1::AnswersController < ApplicationController
  require './app/classes/save_answer'


  skip_before_action :verify_authenticity_token
  def create
    parameters = params[:session].to_unsafe_h  #後で strongparameterかましてto_hにする
    key = parameters[:userid]
    drill_id = parameters[:drillid].to_s.to_sym
    unit_id = parameters[:unitid].to_s.to_sym

    @answer = Answer.find_or_initialize_by(key: key)

    if @answer.new_record? 
    #ユーザのレコードがない時
      save_answer = SaveAnswer.new(parameters, drill_id, unit_id)
      save_answer.init_book

      if @answer = Answer.create(key: key, save_data: save_answer.set_data)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    else
    #ユーザのレコードがある時
      set_data = Marshal.load(Marshal.dump(@answer[:save_data]))
      save_answer = SaveAnswer.new(parameters, drill_id, unit_id, set_data)
      if !@answer[:save_data][drill_id]
        #book_idのレコードがない時は新規作成
        save_answer.init_book
        
      elsif @answer[:save_data][drill_id][:units][unit_id] 
      #unit_idのレコードがある時はunitを追加
        save_answer.edit_unit
        
      elsif @answer[:save_data][drill_id][:units]
        #drill_idのレコードがある時は追加
        save_answer.add_unit
      end
        
      if @answer.update(key: key, save_data: save_answer.set_data)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    end
  end

  def show 
    @answer = Answer.find_by(key: params[:id])

    if @answer 
      render status: 200, json: @answer 
    else
      render status: 400, json: { save_data: '失敗' }
    end
  end
end
