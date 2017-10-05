require 'time'

module KataBabySitter

  ## pay rates
  RATES = [PRE_BED = 12, BED_TO_MIDNIGHT = 8, MIDNIGHT_TO_END = 16]

  ## cut off range
  MIDNIGHT = 24
  HARD_START = Time.parse('5pm')
  HARD_END = Time.parse('4am') + 86400

  def self.calc_payment start_time, end_time, bed_time
    time_range_error if requirements_not_met? start_time, end_time
    order_error if format_time(start_time) > format_time(end_time)
    [calc_pre_bed(start_time, bed_time), calc_bed_to_midnight(bed_time), calc_midnight_to_end(end_time)].sum
  end

  def self.calc_pre_bed start_time, bed_time
    (format_time(bed_time).hour - format_time(start_time).hour) * PRE_BED
  end

  def self.calc_bed_to_midnight bed_time
    (MIDNIGHT - format_time(bed_time).hour) * BED_TO_MIDNIGHT
  end

  def self.calc_midnight_to_end end_time
    format_time(end_time).hour * MIDNIGHT_TO_END
  end

  def self.format_time time
    time.include?('am') ? Time.parse(time) + 86400 : Time.parse(time)
  end

  def self.requirements_not_met? start, stop
    (format_time(start) <= HARD_START || format_time(stop) >= HARD_END)
  end


  def self.time_range_error
    raise ArgumentError.new("Start and end times must be within given range.")
  end


  def self.order_error
    raise ArgumentError.new("Start time must come before end time.")
  end

end