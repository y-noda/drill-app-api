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

  def summary
    users = User.find_by(key: 'users')
    users = users[:save_data]
    user_keys = users.keys
    taken_user_keys = user_keys.select.each do |user_key|
      if params[:grade] && params[:class]
        
        users[user_key][:grade] == params[:grade] && users[user_key][:class].include?(params[:class])
      elsif params[:grade] 
        users[user_key][:grade] == params[:grade]
      elsif params[:class]
        users[user_key][:class].include?(params[:class])
      else
        true
      end

    end

    if users 
      render status: 200, json: taken_user_keys
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

      studyingTime = 0
      answeredQuestionNum = 0
      correctAnswerNum = 0


      if params[:startDate] && params[:endDate]
        
        start_month_gap = (value[:updated_date].to_date.year - params[:startDate].to_date.year) * 12 + (value[:updated_date].to_date.month - params[:startDate].to_date.month)
        end_month_gap = (value[:updated_date].to_date.year - params[:endDate].to_date.year) * 12 + (value[:updated_date].to_date.month - params[:endDate].to_date.month)

        

        startPosition = 11 - start_month_gap 
        endPosition = 11 - end_month_gap

        #studyingTime
        
        array = value[:studyingTime][:dailyArr]

        #初月
        array[startPosition].each_with_index do |el, index|
          if index >= params[:startDate].to_date.day - 1
            studyingTime += el
          end
        end

        #間の月
        if endPosition - startPosition > 1
          for i in (startPosition + 1)..(endPosition - 1)
            studyingTime += array[i].sum
          end
        end


        #終月
        array[endPosition].each_with_index do |el, index|
          if index <= params[:endDate].to_date.day - 1
            studyingTime += el
          end
        end

        # answeredQuestionNum
        
        array = value[:answeredQuestionNum][:dailyArr]

        #初月
        array[startPosition].each_with_index do |el, index|
          if index >= params[:startDate].to_date.day - 1
            answeredQuestionNum += el
          end
        end

        #間の月
        if endPosition - startPosition > 1
          for i in (startPosition + 1)..(endPosition - 1)
            answeredQuestionNum += array[i].sum
          end
        end


        #終月
        array[endPosition].each_with_index do |el, index|
          if index <= params[:endDate].to_date.day - 1
            answeredQuestionNum += el
          end
        end
        

        # correctAnswerNum
        
        array = value[:correctAnswerNum][:dailyArr]

        #初月
        array[startPosition].each_with_index do |el, index|
          if index >= params[:startDate].to_date.day - 1
            correctAnswerNum += el
          end
        end

        #間の月
        if endPosition - startPosition > 1
          for i in (startPosition + 1)..(endPosition - 1)
            correctAnswerNum += array[i].sum
          end
        end


        #終月
        array[endPosition].each_with_index do |el, index|
          if index <= params[:endDate].to_date.day - 1
            correctAnswerNum += el
          end
        end
      else 
        
        studyingTime = value[:studyingTime][:total]
        answeredQuestionNum = value[:answeredQuestionNum][:total]
        correctAnswerNum = value[:correctAnswerNum][:total]
        
      end


      units = []
      u_keys = value[:units].keys

      #unit
      u_keys.each do |u_key|
        
        answeredQSum = 0
        correctANum = 0

        value[:units][u_key][:answers].each do |answer|
          answeredQSum += answer[:answeredQuestionNum]
          answer[:question].each do |question|
            question[:trial].each do |trial|
              if trial[:correct] == true
                correctANum += 1
              end
            end
          end
        end
        if params[:startDate] && params[:endDate]
          len = value[:units][u_key][:answers].length
          date = value[:units][u_key][:answers][len - 1][:dateStart]

          if params[:startDate].to_date < date.to_date && params[:endDate].to_date >= date.to_date
            answeredUnitNum += 1
          end
        else
          answeredUnitNum = u_keys.length
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
            "answeredQuestionNum": answeredQSum, 
            "correctAnswerNum": correctANum
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
            studyingTime: studyingTime,
            answeredUnitNum: u_keys.length,
            answeredQuestionNum: answeredQuestionNum,
            correctAnswerNum: correctAnswerNum
          },
          daily: {
            studyingTimeArr: value[:studyingTime][:dailyArr]
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
