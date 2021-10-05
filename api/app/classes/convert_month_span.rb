class ConvertMonthSpan
  attr_accessor :set_data
  attr_accessor :output_data
  attr_accessor :updated_time

  def initialize(set_data, updated_time)
    @set_data = Marshal.load(Marshal.dump(set_data))
    @updated_time = updated_time
    @output_data = Array.new(12).map{Array.new(31, 0)}
    
  end

  def convert_span

    last_month = updated_time.to_date.month

    if last_month < 4

      april = last_month - 1

    else

      april = 11 - (last_month - 4) 

    end

    index = 0

    for i in april..11
      output_data[index] = set_data[i]
      index += 1
    end

    return output_data

  end

end