class Api::V1::MypagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  require './app/classes/save_answer'

  def log
    @answer = Answer.find_by(key: params[:user_id])

    set_data = Marshal.load(Marshal.dump(@answer[:save_data]))

    keys = @answer[:save_data].keys
    keys.each do |key|
      save_answer = SaveAnswer.new({ "dateStart": DateTime.now }, key, 'kari', set_data)
      save_answer.adjust
    end

    @answer.update(key: params[:user_id], save_data: set_data)

    return_data = []
    keys.each do |key|
      book_id = key.to_s.to_sym
      grade = 1 
      school = "dummy_gakkou"
      subject = set_data[book_id][:subject]
      studyingTime = set_data[book_id][:studyingTime]
      answeredQuestionNum = set_data[book_id][:answeredQuestionNum]
      correctAnswerNum = set_data[book_id][:correctAnswerNum]
      return_data.push(
        { 
          drillid: book_id, 
          grade: grade, 
          school: school, 
          subject: subject, 
          crownNum: { 
            gold: 10, 
            silver: 12, 
            bronze: 3 
          },
          studyingTime: studyingTime, 
          answeredQuestionNum: answeredQuestionNum,
          correctAnswerNum: correctAnswerNum
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
