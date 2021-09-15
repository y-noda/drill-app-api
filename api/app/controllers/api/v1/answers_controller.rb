class Api::V1::AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    parameters = params[:session].to_unsafe_h  #後で strongparameterかましてto_hにする
    key = parameters[:userid]
    book_id = parameters[:workbookid].to_s.to_sym
    sent_month = parameters[:dateStart].to_date.month

    @answer = Answer.find_or_initialize_by(key: key)
    
    if @answer.new_record? 
    #ユーザのレコードがない時
      input_data = {}

      input_data[book_id] = {}

      #回答
      input_data[book_id][:answers] = [parameters]

      #時間
      input_data[book_id][:studyingTime] = {}
      input_data[book_id][:studyingTime][:total] = parameters[:elapsedTime]
      input_data[book_id][:studyingTime][:monthlyArr] = []
      input_data[book_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])

      #回答数
      input_data[book_id][:answeredQuestionNum] = {}
      input_data[book_id][:answeredQuestionNum][:total] = parameters[:answeredQuestionNum]
      input_data[book_id][:answeredQuestionNum][:monthlyArr] = []
      input_data[book_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])

      #最終更新月
      input_data[book_id][:set_month] = sent_month

      if @answer = Answer.create(key: key, save_data: input_data)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    else
    #ユーザのレコードがある時
      input_data = Marshal.load(Marshal.dump(@answer[:save_data]))
      
      if @answer[:save_data][book_id]  
      #book_idのレコードがある時は追加
        #回答
        input_data[book_id][:answers].push(parameters)
        #時間
        input_data[book_id][:studyingTime][:total] += parameters[:elapsedTime]
        #回答数
        input_data[book_id][:answeredQuestionNum][:total] += parameters[:answeredQuestionNum]

          
        #集計
        set_month = input_data[book_id][:set_month]
      
        if sent_month == set_month
          #時間
          input_data[book_id][:studyingTime][:monthlyArr][-1] += parameters[:elapsedTime]
          #回答数
          input_data[book_id][:answeredQuestionNum][:monthlyArr][-1] += parameters[:answeredQuestionNum]
        else
          gap_months = sent_month - set_month - 1
          #久しぶりの送信なら0時間をpushして埋める
          gap_months.times do |i|
            #時間
            input_data[book_id][:studyingTime][:monthlyArr].push(0)
            #回答数
            input_data[book_id][:answeredQuestionNum][:monthlyArr].push(0)
          end
          #時間
          input_data[book_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
          #回答数
          input_data[book_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])

          #最終更新月の更新
          input_data[book_id][:set_month] = sent_month
          #12ヶ月分に調整
          array_length = input_data[book_id][:studyingTime][:monthlyArr].length
          if  array_length > 12
            difference = array_length - 12
            #時間
            input_data[book_id][:studyingTime][:monthlyArr].shift(difference)
            #回答数
            input_data[book_id][:answeredQuestionNum][:monthlyArr].shift(difference)
          end
        end

      else
      #book_idのレコードがない時は新規作成

        input_data[book_id] = {}

        #回答
        input_data[book_id][:answers] = [parameters]

        #時間
        input_data[book_id][:studyingTime] = {}
        input_data[book_id][:studyingTime][:total] = parameters[:elapsedTime]
        input_data[book_id][:studyingTime][:monthlyArr] = []
        input_data[book_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])

        #回答数
        input_data[book_id][:answeredQuestionNum] = {}
        input_data[book_id][:answeredQuestionNum][:total] = parameters[:answeredQuestionNum]
        input_data[book_id][:answeredQuestionNum][:monthlyArr] = []
        input_data[book_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])

        #最終更新月
        input_data[book_id][:set_month] = sent_month

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

    save_data = @answer[:save_data]
    return_data = []
    keys = @answer[:save_data].keys

    keys.each do |key|
      book_id = key.to_s.to_sym
      answers = save_data[book_id][:answers]
      grade = 1 
      school = "dummy_gakkou"
      subject = answers[0][:subject]
      studyingTime = save_data[book_id][:studyingTime]
      answeredQuestionNum = save_data[book_id][:answeredQuestionNum]
      return_data.push(
        { 
          drillid: book_id, 
          grade: grade, 
          school: school, 
          subject: subject, 
          studyingTime: studyingTime, 
          answeredQuestionNum: answeredQuestionNum
        }
      )
    end


    if @answer 
      render status: 200, json: return_data
    else
      render status: 400, json: { save_data: '失敗' }
    end
  end
end
