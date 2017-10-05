require 'time'

class KataBabySitter

  MIDNIGHT = 24
  HARD_START = Time.parse('5pm')
  HARD_END = Time.parse('4am') + 86400

  RATES = [PRE_BED = 12, BED_TO_MIDNIGHT = 8, MIDNIGHT_TO_END = 16]

  attr_reader :start_time, :end_time, :bed_time 


  def initialize start_t, end_t, bed_t
    @start_time = format_time(start_t)
    @end_time = format_time(end_t)
    @bed_time = format_time(bed_t)

    time_range_error if requirements_not_met?
    order_error if start_time > end_time
  end

  def calc_payment
    [calc_pre_bed, calc_bed_to_midnight, calc_midnight_to_end].sum
  end

  def calc_pre_bed
    (bed_time.hour - start_time.hour) * PRE_BED
  end

  def calc_bed_to_midnight
    (MIDNIGHT - bed_time.hour) * BED_TO_MIDNIGHT
  end

  def calc_midnight_to_end
    end_time.hour * MIDNIGHT_TO_END
  end

  def format_time time
    time.include?('am') ? Time.parse(time) + 86400 : Time.parse(time)
  end

  def requirements_not_met?
    (start_time <= HARD_START || end_time >= HARD_END)
  end


  def time_range_error
    raise ArgumentError.new("Start and end times must be within given range.")
  end


  def order_error
    raise ArgumentError.new("Start time must come before end time.")
  end

end