class SaveAnswer
  attr_accessor :set_data
  attr_accessor :parameters
  attr_accessor :drill_id
  attr_accessor :unit_id
  attr_accessor :sent_date

  def initialize(init_data = {}, parameters, drill_id, unit_id)
    @set_data = init_data
    @parameters = parameters
    @sent_date= parameters[:dateStart]
    @drill_id = drill_id
    @unit_id = unit_id
  end

  def init_book
  #新規作成
    #初期化
    set_data[drill_id] = {}
    set_data[drill_id][unit_id] = {}
    set_data[drill_id][:studyingTime] = {}
    set_data[drill_id][:studyingTime][:total] = 0
    set_data[drill_id][:studyingTime][:dailyArr] = Array.new(12).map{Array.new(31, 0)}
    

    #教科
    set_data[drill_id][:subject] = parameters[:subject]
    #回答
    set_data[drill_id][unit_id][:answers] = parameters
    #時間
    set_data[drill_id][:studyingTime][:total] = parameters[:elapsedTime]

    #最終更新日
    set_data[drill_id][:updated_date] = sent_date


  end

  def add_book
    #回答
    set_data[drill_id][:answers].push(parameters)
    #時間
    set_data[drill_id][:studyingTime][:total] += parameters[:elapsedTime]
    #回答数
    set_data[drill_id][:answeredQuestionNum][:total] += parameters[:answeredQuestionNum]
    #正答数
    correct_answer_num = count_correct_answer
    set_data[drill_id][:correctAnswerNum][:total] += correct_answer_num
    
    #最終更新月
    set_year = set_data[drill_id][:set_year] 
    set_month = set_data[drill_id][:set_month] 
    
    #集計のadd
    counting(set_year, set_month, correct_answer_num)
  end

  def add_unit

  end

  protected 
    def counting(set_year, set_month, correct_answer_num)
      
      if sent_year == set_year && sent_month == set_month 
        #時間
        set_data[drill_id][:studyingTime][:monthlyArr][-1] += parameters[:elapsedTime]
        #回答数
        set_data[drill_id][:answeredQuestionNum][:monthlyArr][-1] += parameters[:answeredQuestionNum]
        #正答数
        set_data[drill_id][:correctAnswerNum][:monthlyArr][-1] += correct_answer_num

      else
        #久しぶりの送信なら0時間をpushして埋める
        fill_gap(set_year, set_month)
        #時間
        set_data[drill_id][:studyingTime][:monthlyArr].push(parameters[:elapsedTime])
        #回答数
        set_data[drill_id][:answeredQuestionNum][:monthlyArr].push(parameters[:answeredQuestionNum])
        #正答数
        set_data[drill_id][:correctAnswerNum][:monthlyArr].push(correct_answer_num)

        #最終履歴時間の更新
        set_data[drill_id][:set_year] = sent_year
        set_data[drill_id][:set_month] = sent_month

        #12ヶ月分に調整
        limit_months_array(12)

      end
    end 

    def fill_gap(set_year, set_month)

      if sent_year == set_year && sent_month != set_month 
      #月が違うだけ
        if sent_month > set_month
        # 正しい月順
          gap_months = sent_month - set_month - 1
          push_zero(gap_months)
        else 
        #異常な月順はリセット
           #時間
           set_data[drill_id][:studyingTime][:monthlyArr] = []
           #回答数
           set_data[drill_id][:answeredQuestionNum][:monthlyArr] = []
           #正答数
           set_data[drill_id][:correctAnswerNum][:monthlyArr] = []
        end

      else
      #年が異なる
        year_gap = sent_year - set_year
        if sent_year < set_year || sent_month >= set_month || year_gap > 1
        #異常な年順または一年以上たってる場合はリセット
          #時間
          set_data[drill_id][:studyingTime][:monthlyArr] = []
          #回答数
          set_data[drill_id][:answeredQuestionNum][:monthlyArr] = []
          #正答数
          set_data[drill_id][:correctAnswerNum][:monthlyArr] = []
        elsif sent_month < set_month 
        # 一年以内の場合
          gap_months = (sent_month - 1) +  (12 - set_month) 
          push_zero(gap_months)
        end
        
      end
    end

    def push_zero(gap_months)
      gap_months.times do |i|
        #時間
        set_data[drill_id][:studyingTime][:monthlyArr].push(0)
        #回答数
        set_data[drill_id][:answeredQuestionNum][:monthlyArr].push(0)
        #正答数
        set_data[drill_id][:correctAnswerNum][:monthlyArr].push(0)
      end
    end

    def limit_months_array(num)
      array_length = set_data[book_id][:studyingTime][:monthlyArr].length
      if  array_length > num
        difference = array_length - num
        #時間
        set_data[drill_id][:studyingTime][:monthlyArr].shift(difference)
        #回答数
        set_data[drill_id][:answeredQuestionNum][:monthlyArr].shift(difference)
        #正答数
        set_data[drill_id][:correctAnswerNum][:monthlyArr].shift(difference)
      end
    end

    def count_correct_answer
      count = 0
      parameters[:question].each do |question|
        question[:trial].each do |ans|
          if ans[:correct]  
            count = count + 1
          end
        end
      end
      return count
    end

end