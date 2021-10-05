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
    set_data[drill_id][:units][unit_id][:crown] = '' 
    set_data[drill_id][:units][unit_id][:unitTitle] = ''

    sum_array = [:studyingTime, :answeredQuestionNum, :correctAnswerNum]

    sum_array.each do |name|
      set_data[drill_id][name] = {}
      set_data[drill_id][name][:total] = 0
      set_data[drill_id][name][:dailyArr] = Array.new(12).map{Array.new(31, 0)}
    end

    set_data[drill_id][:updated_date] = DateTime.now

    #教科
    set_data[drill_id][:subject] = parameters[:subject]
    #学年
    set_data[drill_id][:grade] = parameters[:grade]
    #学校
    set_data[drill_id][:school] = parameters[:school]

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

  def adjust
    fill_gap
  end

  protected 

    def fill_gap
      
      gap = (sent_date.to_date.year - set_data[drill_id][:updated_date].to_date.year) * 12 + (sent_date.to_date.month - set_data[drill_id][:updated_date].to_date.month)
      
      if gap < 12
        #同じ年度12ヶ月以内gap月分埋める
        gap.times do |i|

          sum_array = [:studyingTime, :answeredQuestionNum, :correctAnswerNum]

          sum_array.each do |name|
            set_data[drill_id][name][:dailyArr].push(Array.new(31, 0))
            set_data[drill_id][name][:total] -= set_data[drill_id][name][:dailyArr][0].sum
            set_data[drill_id][name][:dailyArr].delete_at(0)
          end

        end

      elsif gap >= 12 || gap < 0
        #12ヶ月以上または不正な送信日時の場合リセット

        sum_array = [:studyingTime, :answeredQuestionNum, :correctAnswerNum]

        sum_array.each do |name|
          set_data[drill_id][name][:total] = 0
          set_data[drill_id][name][:dailyArr] = Array.new(12).map{Array.new(31, 0)}
        end

      end

      #最終更新日
      set_data[drill_id][:updated_date] = sent_date

    end

    def count_correct_answer
      count = 0
      parameters[:question].each do |question|
        if question[:trial][0][:correct]  
            count = count + 1
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

      if parameters[:crown] == 'gold' || set_data[drill_id][:units][unit_id][:crown] == 'gold'
        set_data[drill_id][:units][unit_id][:crown] = 'gold'
      elsif parameters[:crown] == 'silver' || set_data[drill_id][:units][unit_id][:crown] == 'silver'
        set_data[drill_id][:units][unit_id][:crown] = 'silver'
      elsif parameters[:crown] == 'bronze' || set_data[drill_id][:units][unit_id][:crown] == 'bronze'
        set_data[drill_id][:units][unit_id][:crown] = 'bronze'
      end

      set_data[drill_id][:units][unit_id][:unitTitle] = parameters[:unitTitle]
      
      #最終更新年、月が違う場合は処理がいる
      fill_gap
      
      set_data[drill_id][:studyingTime][:dailyArr][11][sent_date.to_date.day - 1] += parameters[:elapsedTime]
      set_data[drill_id][:answeredQuestionNum][:dailyArr][11][sent_date.to_date.day - 1] += parameters[:answeredQuestionNum]
      set_data[drill_id][:correctAnswerNum][:dailyArr][11][sent_date.to_date.day - 1] += count_correct_answer

    end

end