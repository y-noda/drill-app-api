class Api::V1::AnswersController < ApplicationController
  require './app/classes/save_answer'
  skip_before_action :verify_authenticity_token
  def create
    parameters = params[:session].to_unsafe_h  #後で strongparameterかましてto_hにする
    key = parameters[:userid]
    book_id = parameters[:workbookid].to_s.to_sym
    
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
          },
          loginCountNum: {
            total: 315,
            monthlyArr: [5, 15, 20, 10, 8, 6, 21, 45, 9, 61, 77, 45]
          },
          correctAnswerNum: {
            total: '',
            monthlyArr: []
          }
        }
      }

      save_answer = SaveAnswer.new(set_data, parameters, book_id)
      save_answer.fill

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
        save_answer = SaveAnswer.new(set_data, parameters, book_id)
        save_answer.add
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
          },
          loginCountNum: {
            total: 315,
            monthlyArr: [5, 15, 20, 10, 8, 6, 21, 45, 9, 61, 77, 45]
          },
          correctAnswerNum: {
            total: '',
            monthlyArr: []
          }
        }
        save_answer = SaveAnswer.new(set_data, parameters, book_id)
        save_answer.fill
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
      loginCountNum = save_data[book_id][:loginCountNum]
      correctAnswerNum = save_data[book_id][:correctAnswerNum]
      return_data.push(
        { 
          drillid: book_id, 
          grade: grade, 
          school: school, 
          subject: subject, 
          studyingTime: studyingTime, 
          answeredQuestionNum: answeredQuestionNum,
          loginCountNum: loginCountNum,
          correctAnswerNum: correctAnswerNum,
          achievementRate: 25
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
