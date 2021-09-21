class Api::V1::MypagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def log
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
