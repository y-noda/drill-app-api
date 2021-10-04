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

    keys = drills.keys

    return_data = {}

    return_data[:user] = user

    crown = { gold: 0, silver: 0, bronze: 0 }

    keys.each do |key|

      value = drills[key]

      units = []
      
      u_keys = value[:units].keys

      u_keys.each do |u_key|
        
        answeredQuestionSum = 0
        correctAnswerNum = 0

        value[:units][u_key][:answers].each do |answer|
          answeredQuestionSum += answer[:answeredQuestionNum]
          answer[:question].each do |question|
            question[:trial].each do |trial|
              if trial[:correct] == true
                correctAnswerNum += 1
              end
            end
          end
        end

        if value[:units][u_key][:crown] == 'gold'
          crown[:gold] += 1
        elsif value[:units][u_key][:crown] == 'silver'
          crown[:silver] += 1
        elsif value[:units][u_key][:crown] == 'bronze'
          crown[:bronze] += 1
        end


        units.push(
          {
            "id": u_key,
            "title": u_key,
            "answeredQuestionNum": answeredQuestionSum, 
            "correctAnswerNum": correctAnswerNum
          }
        )
      end
      
      return_data[:drills] = []

      return_data[:drills].push(
        {
          info: {
            drillid: key,
            grade: "soushindataniirete",
            school: "soushindataniirete",
            subject: value[:subject]
          },
          log: {
            studyingTime: value[:studyingTime][:total],
            answeredUnitNum: u_keys.length,
            answeredQuestionNum: value[:answeredQuestionNum][:total],
            correctAnswerNum: value[:correctAnswerNum][:total]
          },
          daily: {
            studyingTimeArr: []
          },
          units: units
        }
      )

      return_data[:user][:crownNum] = crown

    end


    if user 
      render status: 200, json: return_data
    else
      render status: 400, json: { save_data: '失敗' }
    end

  end
end
