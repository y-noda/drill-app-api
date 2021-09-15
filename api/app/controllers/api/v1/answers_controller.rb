class Api::V1::AnswersController < ApplicationController
  require './app/classes/save_answer'
  skip_before_action :verify_authenticity_token
  def create
    parameters = params[:session].to_unsafe_h  #後で strongparameterかましてto_hにする
    key = parameters[:userid]
    book_id = parameters[:workbookid].to_s.to_sym
    sent_month = parameters[:dateStart].to_date.month

    @answer = Answer.find_or_initialize_by(key: key)

    if @answer.new_record? 
    #ユーザのレコードがない時
      set_data = {
        "#{book_id}": {
          answers: [],
          studyingTime: {
            total: '',
            monthlyArr: []
          },
          answeredQuestionNum: {
            total: '',
            monthlyArr: []
          }
        }
      }

      save_answer = SaveAnswer.new(set_data)
      save_answer.fill(parameters, sent_month, book_id)

      if @answer = Answer.create(key: key, save_data: save_answer.set_data)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    else
    #ユーザのレコードがある時
      set_data = Marshal.load(Marshal.dump(@answer[:save_data]))
      if @answer[:save_data][book_id]  
      #book_idのレコードがある時は追加
        save_answer = SaveAnswer.new(set_data)
        save_answer.add(parameters, sent_month, book_id)
      else
      #book_idのレコードがない時は新規作成
        set_data[book_id] = {
          answers: [],
          studyingTime: {
            total: '',
            monthlyArr: []
          },
          answeredQuestionNum: {
            total: '',
            monthlyArr: []
          }
        }
        save_answer = SaveAnswer.new(set_data)
        save_answer.fill(parameters, sent_month, book_id)
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
