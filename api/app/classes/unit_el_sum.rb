class UnitElSum
  attr_accessor :unit_keys
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :updated_time
  attr_accessor :summary
  attr_accessor :answers


  def initialize(unit_keys, answers, start_date, end_date, updated_time)
    @unit_keys = unit_keys
    @answers = answers
    @start_date = start_date.to_date
    @end_date = end_date.to_date
    @updated_time = updated_time.to_date
    @summary = 0
  end

  def fetch_sum
    unit_keys.each do |unit_key|
      
      answers = self.answers[unit_key][:answers]

      answers.each do |answer|
        date = answer[:dateStart].to_date
        if start_date.to_date <= updated_time.to_date && end_date.to_date >= updated_time.to_date
          self.summary += 1
        end
      end
    end

    return summary

  end

end