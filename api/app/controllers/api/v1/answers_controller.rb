class Api::V1::AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    parameters = params[:session].to_unsafe_h  #後で strongparameterかましてto_hにする
    key = parameters[:userid]
    book_id = parameters[:workbookid].to_s.to_sym

    @answer = Answer.find_or_initialize_by(key: key)
    sent_month = parameters[:dateStart].to_date.month

    if @answer.new_record? 
      #ユーザのレコードがない時
      input_data = { 
        data_per_book: {}, 
        total_data: {
          studyingTime: {
            total: 0, 
            monthlyArr: [] 
          },
          set_month: sent_month
        } 
      }
      #回答
      input_data[:data_per_book][book_id] = [parameters]
      #時間
      input_data[:total_data][:studyingTime][:total] = parameters[:elapsedTime]
      input_data[:total_data][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
      

      if @answer = Answer.create(key: key, save_data: input_data)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    else
      #回答
      if @answer[:save_data][:data_per_book][book_id]  
        #book_idのレコードがある時は追加
        input_data = Marshal.load(Marshal.dump(@answer[:save_data]))
        input_data[:data_per_book][book_id].push(parameters)
        
      else
        #book_idのレコードがない時は新規作成
        input_data = Marshal.load(Marshal.dump(@answer[:save_data]))
        input_data[:data_per_book][book_id] = [parameters]
      end

      #時間
      input_data[:total_data][:studyingTime][:total] = input_data[:total_data][:studyingTime][:total] + parameters[:elapsedTime]
      
      set_month = input_data[:total_data][:set_month]
      
      if sent_month == set_month
        input_data[:total_data][:studyingTime][:monthlyArr][-1] = input_data[:total_data][:studyingTime][:monthlyArr][-1] + parameters[:elapsedTime]
      else
        gap_months = sent_month - set_month - 1
        #久しぶりの送信なら0時間をpushして埋める
        gap_months.times do |i|
          input_data[:total_data][:studyingTime][:monthlyArr].push(0)
        end
        input_data[:total_data][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
        #最終更新月の更新
        input_data[:total_data][:set_month] = sent_month
        #12ヶ月分に調整
        array_length = input_data[:total_data][:studyingTime][:monthlyArr].length
        if  array_length > 12
          difference = array_length - 12
          input_data[:total_data][:studyingTime][:monthlyArr].shift(difference)
        end

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
