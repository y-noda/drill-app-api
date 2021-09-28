class SaveAnswer
  attr_accessor :set_data
  attr_accessor :parameters
  attr_accessor :drill_id
  attr_accessor :unit_id
  attr_accessor :sent_date

  def initialize(parameters, drill_id, unit_id, init_data = {})
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
    set_data[drill_id][:units] = {}
    set_data[drill_id][:units][unit_id] = {}
    set_data[drill_id][:units][unit_id][:answers] = []

    set_data[drill_id][:studyingTime] = {}
    set_data[drill_id][:studyingTime][:total] = 0
    set_data[drill_id][:studyingTime][:dailyArr] = Array.new(12).map{Array.new(32, 0)}

    set_data[drill_id][:answeredQuestionNum] = {}
    set_data[drill_id][:answeredQuestionNum][:total] = 0
    set_data[drill_id][:answeredQuestionNum][:dailyArr] = Array.new(12).map{Array.new(32, 0)}

    set_data[drill_id][:correctAnswerNum] = {}
    set_data[drill_id][:correctAnswerNum][:total] = 0
    set_data[drill_id][:correctAnswerNum][:dailyArr] = Array.new(12).map{Array.new(32, 0)}

    #教科
    set_data[drill_id][:subject] = parameters[:subject]

    set_unit
    
  end

  def edit_unit
    set_unit
  end

  def add_unit
    #初期化
    set_data[drill_id][:units][unit_id] = {}
    set_data[drill_id][:units][unit_id][:answers] = []

    set_unit
  end

  protected 
    def reset_month
      if sent_date.to_date.year != set_data[drill_id][:studyingTime][:dailyArr][sent_date.to_date.month - 1][31]
        set_data[drill_id][:studyingTime][:dailyArr][sent_date.to_date.month - 1] = Array.new(32, 0)
        set_data[drill_id][:studyingTime][:dailyArr][sent_date.to_date.month - 1][31] = sent_date.to_date.year

        set_data[drill_id][:answeredQuestionNum][:dailyArr][sent_date.to_date.month - 1] = Array.new(32, 0)
        set_data[drill_id][:answeredQuestionNum][:dailyArr][sent_date.to_date.month - 1][31] = sent_date.to_date.year

        set_data[drill_id][:correctAnswerNum][:dailyArr][sent_date.to_date.month - 1] = Array.new(32, 0)
        set_data[drill_id][:correctAnswerNum][:dailyArr][sent_date.to_date.month - 1][31] = sent_date.to_date.year
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

    def set_unit
      #回答
      set_data[drill_id][:units][unit_id][:answers].push(parameters)
      #時間
      set_data[drill_id][:studyingTime][:total] += parameters[:elapsedTime]
      set_data[drill_id][:answeredQuestionNum][:total] += parameters[:answeredQuestionNum]
      correct_num = count_correct_answer
      set_data[drill_id][:correctAnswerNum][:total] += count_correct_answer

      #年が違う場合はリセットがいる
      reset_month
      set_data[drill_id][:studyingTime][:dailyArr][sent_date.to_date.month - 1][sent_date.to_date.day - 1] += parameters[:elapsedTime]
      set_data[drill_id][:answeredQuestionNum][:dailyArr][sent_date.to_date.month - 1][sent_date.to_date.day - 1] += parameters[:answeredQuestionNum]
      set_data[drill_id][:correctAnswerNum][:dailyArr][sent_date.to_date.month - 1][sent_date.to_date.day - 1] += count_correct_answer

      #最終更新日
      set_data[drill_id][:updated_date] = sent_date
    end

end