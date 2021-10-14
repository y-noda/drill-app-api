class Api::V1::UsersController < ApplicationController

  require './app/classes/save_answer'
  require './app/classes/month_array_sum'
  require './app/classes/convert_month_span'

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
        users[user_key][:grade] == params[:grade] && users[user_key][:class].include?(params[:class]) && users[user_key][:role] == 'student'
      elsif params[:grade] 
        users[user_key][:grade] == params[:grade] && users[user_key][:role] == 'student'
      elsif params[:class]
        users[user_key][:class].include?(params[:class]) && users[user_key][:role] == 'student'
      else
        users[user_key][:role] == 'student'
      end
    end

    daily_study_sum = 0
    answer_question_sum = 0
    correct_answer_sum = 0
    study_count_sum = 0

    taken_user_keys.each do |user_key|

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
          daily_st_count_array = user_answer[i][:studyCountNum][:dailyArr]


          updated_date = user_answer[i][:updated_date]

          if params[:startDate] && params[:endDate]
            month_sum = MonthArraySum.new(daily_study_array, params[:startDate], params[:endDate], updated_date)
            daily_study_sum += month_sum.array_sum

            month_sum = MonthArraySum.new(daily_answer_array, params[:startDate], params[:endDate], updated_date)
            answer_question_sum += month_sum.array_sum

            month_sum = MonthArraySum.new(daily_correct_array, params[:startDate], params[:endDate], updated_date)
            correct_answer_sum += month_sum.array_sum

            #studyCountNum
            month_sum = MonthArraySum.new(daily_st_count_array, params[:startDate], params[:endDate], updated_date)
            study_count_sum += month_sum.array_sum

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

            daily_st_count_array.each do |array|
              study_count_sum += array.sum
            end

          end

        end
      end
    end

    return_data = {
      "studyingTime": daily_study_sum, 
      "studyCountNum": study_count_sum, 
      "answeredQuestionNum": answer_question_sum, 
      "correctAnswerNum": correct_answer_sum,
      "userNum": taken_user_keys.length
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

    if user && drills
      
      #同期
      set_data = Marshal.load(Marshal.dump(drills[:save_data]))

      keys = drills[:save_data].keys

      keys.each do |key|
        save_answer = SaveAnswer.new({ "dateStart": DateTime.now }, key, 'kari', set_data)
        save_answer.adjust
      end

      drills.update(key: params[:id], save_data: set_data)


      drills = drills[:save_data]

      keys = drills.keys

      return_data = {}

      return_data[:user] = user
      return_data[:drills] = []

      crown = { gold: 0, silver: 0, bronze: 0 }

      keys.each do |key|
        value = drills[key]

        studyingTime = 0
        answeredQuestionNum = 0
        correctAnswerNum = 0
        answeredUnitNum = 0
        study_count_Num = 0

        daily_study_array = value[:studyingTime][:dailyArr]
        daily_answer_array = value[:answeredQuestionNum][:dailyArr]
        daily_correct_array = value[:correctAnswerNum][:dailyArr]
        daily_st_count_array = value[:studyCountNum][:dailyArr]
        updated_date = value[:updated_date]


        if params[:startDate] && params[:endDate]
          
          month_sum = MonthArraySum.new(daily_study_array, params[:startDate], params[:endDate], updated_date)
          studyingTime += month_sum.array_sum

          month_sum = MonthArraySum.new(daily_answer_array, params[:startDate], params[:endDate], updated_date)
          answeredQuestionNum += month_sum.array_sum

          month_sum = MonthArraySum.new(daily_correct_array, params[:startDate], params[:endDate], updated_date)
          correctAnswerNum += month_sum.array_sum

          #studyCountNum
          month_sum = MonthArraySum.new(daily_st_count_array, params[:startDate], params[:endDate], updated_date)
          studyCountNum += month_sum.array_sum
          
        else 
          
          studyingTime = value[:studyingTime][:total]
          answeredQuestionNum = value[:answeredQuestionNum][:total]
          correctAnswerNum = value[:correctAnswerNum][:total]
          study_count_Num += value[:studyCountNum][:total]
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

            if params[:startDate].to_date <= date.to_date && params[:endDate].to_date >= date.to_date
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
              "title": value[:units][u_key][:unitTitle],
              "answeredQuestionNum": answeredQSum, 
              "correctAnswerNum": correctANum
            }
          )
        end

        studay_time_calc = ConvertMonthSpan.new(value[:studyingTime][:dailyArr], value[:updated_date])

        studyingTimeArr = studay_time_calc.convert_span

        return_data[:drills].push(
          {
            info: {
              drillid: key,
              grade: value[:grade],
              school: value[:school],
              subject: value[:subject]
            },
            log: {
              studyingTime: studyingTime,
              studyCountNum: study_count_Num,
              answeredUnitNum: answeredUnitNum,
              answeredQuestionNum: answeredQuestionNum,
              correctAnswerNum: correctAnswerNum
            },
            daily: {
              studyingTimeArr: studyingTimeArr
            },
            units: units
          }
        )

        return_data[:user][:crownNum] = crown

      end

      render status: 200, json: return_data

    else

      return_data = {
        user: {
          userid: "",
          name: "",
          school: "",
          grade: "",
          schoolid: "",
          class: 
            ["", ""],
          lastLoginDate: "",
          img: "",
          role: "",
          password: "",
          crownNum: {
            gold: 0,
            silver: 0, 
            bronze: 0
          },
          latest_drill: ""
        },
        drills: [
          {
            info: {
              drillid: "",
              grade: "",
              school: "",
              subject: ""
            },
            log: {
              studyingTime: 0,
              studyCountNum: 0,
              answeredUnitNum: 0,
              answeredQuestionNum: 0,
              correctAnswerNum: 0
            },
            daily: {
              studyingTimeArr: [
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
              ]
            },
            units: [
              {
                id: "",
                title: "",
                answeredQuestionNum: 0,
                correctAnswerNum: 0
              }
            ]
          }
        ]
    }

      render status: 200, json: return_data

    end

  end


end
