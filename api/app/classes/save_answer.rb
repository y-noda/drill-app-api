class SaveAnswer
  attr_accessor :set_data

  def initialize(init_data)
    @set_data = init_data
  end

  def fill(parameters, sent_month, book_id)
  #新規作成
    #回答
    self.set_data[book_id][:answers].push(parameters)
    #時間
    self.set_data[book_id][:studyingTime][:total] = parameters[:elapsedTime]
    self.set_data[book_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
    #回答数

    self.set_data[book_id][:answeredQuestionNum][:total] = parameters[:answeredQuestionNum]
    self.set_data[book_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])

    #最終更新月
    self.set_data[book_id][:set_month] = sent_month
  end

  def add(parameters, sent_month, book_id)
    #回答
    self.set_data[book_id][:answers].push(parameters)
    #時間
    self.set_data[book_id][:studyingTime][:total] += parameters[:elapsedTime]
    #回答数
    self.set_data[book_id][:answeredQuestionNum][:total] += parameters[:answeredQuestionNum]
    #集計
    set_month = self.set_data[book_id][:set_month]
  
    if sent_month == set_month
      #時間
      self.set_data[book_id][:studyingTime][:monthlyArr][-1] += parameters[:elapsedTime]
      #回答数
      self.set_data[book_id][:answeredQuestionNum][:monthlyArr][-1] += parameters[:answeredQuestionNum]
    else
      gap_months = sent_month - set_month - 1
      #久しぶりの送信なら0時間をpushして埋める
      gap_months.times do |i|
        #時間
        self.set_data[book_id][:studyingTime][:monthlyArr].push(0)
        #回答数
        self.set_data[book_id][:answeredQuestionNum][:monthlyArr].push(0)
      end
      #時間
      self.set_data[book_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
      #回答数
      self.set_data[book_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])
      #最終更新月の更新
      self.set_data[book_id][:set_month] = sent_month
      #12ヶ月分に調整
      array_length = self.set_data[book_id][:studyingTime][:monthlyArr].length
      if  array_length > 12
        difference = array_length - 12
        #時間
        self.set_data[book_id][:studyingTime][:monthlyArr].shift(difference)
        #回答数
        self.set_data[book_id][:answeredQuestionNum][:monthlyArr].shift(difference)
      end
    end
  end
end