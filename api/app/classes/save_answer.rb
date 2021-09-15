class SaveAnswer
  attr_accessor :set_data
  attr_accessor :parameters
  attr_accessor :book_id
  attr_accessor :sent_month

  def initialize(init_data, parameters, book_id)
    @set_data = init_data
    @parameters = parameters
    @sent_month = parameters[:dateStart].to_date.month
    @book_id = book_id
  end

  def fill
  #新規作成
    #回答
    set_data[book_id][:answers].push(parameters)
    #時間
    set_data[book_id][:studyingTime][:total] = parameters[:elapsedTime]
    set_data[book_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
    #回答数

    set_data[book_id][:answeredQuestionNum][:total] = parameters[:answeredQuestionNum]
    set_data[book_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])

    #最終更新月
    set_data[book_id][:set_month] = sent_month
  end

  def add
    #回答
    set_data[book_id][:answers].push(parameters)
    #時間
    set_data[book_id][:studyingTime][:total] += parameters[:elapsedTime]
    #回答数
    set_data[book_id][:answeredQuestionNum][:total] += parameters[:answeredQuestionNum]
    #最終更新月
    set_month = set_data[book_id][:set_month]
    #集計
    counting(set_month)
  end

  protected 
    def counting(set_month)
      
      if sent_month == set_month
        #時間
        set_data[book_id][:studyingTime][:monthlyArr][-1] += parameters[:elapsedTime]
        #回答数
        set_data[book_id][:answeredQuestionNum][:monthlyArr][-1] += parameters[:answeredQuestionNum]
      else
        #久しぶりの送信なら0時間をpushして埋める
        push_zero(set_month)
        
        #時間
        set_data[book_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
        #回答数
        set_data[book_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])
        #最終更新月の更新
        set_data[book_id][:set_month] = sent_month

        #12ヶ月分に調整
        limit_months_array(12)

      end
    end 

    def push_zero(set_month)
      gap_months = sent_month - set_month - 1
      gap_months.times do |i|
        #時間
        set_data[book_id][:studyingTime][:monthlyArr].push(0)
        #回答数
        set_data[book_id][:answeredQuestionNum][:monthlyArr].push(0)
      end
    end

    def limit_months_array(num)
      array_length = set_data[book_id][:studyingTime][:monthlyArr].length
      if  array_length > num
        difference = array_length - num
        #時間
        set_data[book_id][:studyingTime][:monthlyArr].shift(difference)
        #回答数
        set_data[book_id][:answeredQuestionNum][:monthlyArr].shift(difference)
      end
    end

end