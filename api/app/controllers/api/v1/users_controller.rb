class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index 
    users = User.find_by(key: 'users')
    users = users[:save_data].values
  
    if users 
      render status: 200, json: users
    else
      render status: 400, json: { save_data: '失敗' }
    end
  end

  def show
    users = User.find_by(key: 'users')
    user = users[:save_data][params[:id]]

    drills = Answer.find_by(key: params[:id])
    drills = drills[:save_data]
    drills = drills.values

    return_data = {}

    return_data[:user] = user

    return_data[:drills] = []

    drills.each do |drill|
      return_data[:drills].push(
        {
          info: {
            drillid: drill[:answers][0][:workbookid],
            grade: "soushindataniirete",
            school: "soushindataniirete",
            subject: drill[:answers][0][:subject]
          },
          log: {
            studyingTime: drill[:studyingTime][:total],
            studyCountNum: drill[:studyingTime][:total],
            answeredUnitNum: drill[:studyingTime][:total],
            answeredQuestionNum: drill[:answeredQuestionNum][:total],
            correctAnswerNum: drill[:correctAnswerNum][:total]
          },
          daily: {
            studyingTimeArr: []
          },
          units:[
            {
                id: "japanese_el_grd1_1",
                title: "かんじの　よみ",
                answeredQuestionNum: 932, 
                correctAnswerNum: 80, 
            },
            {
                id: "japanese_el_grd1_2",
                title: "かんじの　かき",
                answeredQuestionNum: 932,
                correctAnswerNum: 80
            }
          ]
        }
      )

    end
    
  
    if user 
      render status: 200, json: return_data
    else
      render status: 400, json: { save_data: '失敗' }
    end

  end
end
