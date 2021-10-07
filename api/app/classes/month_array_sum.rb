class MonthArraySum

  attr_accessor :month_array
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :updated_time
  attr_accessor :summary


  def initialize(month_array, start_date, end_date, updated_time)
    @month_array = month_array
    @start_date = start_date.to_date
    @end_date = end_date.to_date
    @updated_time = updated_time.to_date
    @summary = 0

    
  end

  def array_sum
    start_month_gap = (updated_time.year - start_date.year) * 12 + (updated_time.month - start_date.month)
    end_month_gap = (updated_time.year - end_date.to_date.year) * 12 + (updated_time.month - end_date.to_date.month)
    #何列目の配列？
    startPosition = 11 - start_month_gap 
    endPosition = 11 - end_month_gap

    if start_date != end_date && start_date < end_date
      
      if endPosition - startPosition == 0
        month_array[startPosition].each_with_index do |el, index|
          if index >= start_date.day - 1 && index <= end_date.day - 1
            
            self.summary += el
          end
        end
      else
        #初月
        month_array[startPosition].each_with_index do |el, index|
          if index >= start_date.day - 1
            
            self.summary += el
          end
        end

        #間の月々
        if endPosition - startPosition > 1
          for i in (startPosition + 1)..(endPosition - 1)
            self.summary += month_array[i].sum
          end
        end

        #終月
        month_array[endPosition].each_with_index do |el, index|
          if index <= end_date.day - 1
            self.summary += el
          end
        end

      end
    elsif start_date == end_date

      self.summary += month_array[startPosition][start_date.day - 1]

    else
      month_array.each do |array|
        self.summary += array.sum
      end
    end

    return self.summary

  end


end