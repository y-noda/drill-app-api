class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  require './app/classes/save_answer'
  require './app/classes/month_array_sum'


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
    
    #必要なuserlistをuser_keysとして取り出し
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

    daily_study_sum = 0
    answer_question_sum = 0
    correct_answer_sum = 0
    study_count_sum = 0

    user_keys.each do |user_key|

      @answer = Answer.find_by(key: user_key)

      if @answer

        #同期
        set_data = Marshal.load(Marshal.dump(@answer[:save_data]))

        keys = @answer[:save_data].keys
        keys.each do |key|
          save_answer = SaveAnswer.new({ "dateStart": DateTime.now }, key, 'kari', set_data)
          save_answer.adjust
        end

        @answer.update(key: user_key, save_data: set_data)


        user_answer = @answer[:save_data]
        book_keys = user_answer.keys

        #教科
        if params[:subject]
          book_keys = book_keys.select.each do |book_key|
            user_answer[book_key][:subject] == params[:subject]
          end
        end

        book_keys.each do |i|
          daily_study_array = user_answer[i][:studyingTime][:dailyArr]
          daily_answer_array = user_answer[i][:answeredQuestionNum][:dailyArr]
          daily_correct_array = user_answer[i][:correctAnswerNum][:dailyArr]

          updated_date = user_answer[i][:updated_date]

          if params[:startDate] && params[:endDate]
            month_sum = MonthArraySum.new(daily_study_array, params[:startDate], params[:endDate], updated_date)
            daily_study_sum += month_sum.array_sum

            month_sum = MonthArraySum.new(daily_answer_array, params[:startDate], params[:endDate], updated_date)
            answer_question_sum += month_sum.array_sum

            month_sum = MonthArraySum.new(daily_correct_array, params[:startDate], params[:endDate], updated_date)
            correct_answer_sum += month_sum.array_sum


            #studyCountNum

            unit_keys = user_answer[i][:units].keys

            unit_keys.each do |unit_key|
              answers = user_answer[i][:units][unit_key][:answers]

              answers.each do |answer|
                date = answer[:dateStart].to_date
                if params[:startDate].to_date <= date.to_date && params[:endDate].to_date >= date.to_date
                  study_count_sum += 1
                end
              end
            end

          else
            daily_study_array.each do |array|
              daily_study_sum += array.sum
            end

            daily_answer_array.each do |array|
              answer_question_sum += array.sum
            end

            daily_correct_array.each do |array|
              correct_answer_sum += array.sum
            end

            study_count_sum += user_answer[i][:units].keys.length
          end

        end
      end
    end

    return_data = {
      "studyingTime": daily_study_sum, 
      "studyCountNum": study_count_sum, 
      "answeredQuestionNum": answer_question_sum, 
      "correctAnswerNum": correct_answer_sum
    }

    if users && return_data
      render status: 200, json: return_data
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
