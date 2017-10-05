require 'time'

class KataBabySitter

  DAY_IN_SECS = 86_400
  MIDNIGHT = 24
  HARD_START = Time.parse('5pm')
  HARD_END = Time.parse('4am') + DAY_IN_SECS

  RATES = [PRE_BED = 12, BED_TO_MIDNIGHT = 8, MIDNIGHT_TO_END = 16]

  attr_reader :start_time, :end_time, :bed_time

  def initialize start_t, end_t, bed_t

    begin

      @start_time = format_time(start_t)
      @end_time = format_time(end_t)
      @bed_time = format_time(bed_t)

    rescue
      raise 'Please verify that you are entering your hours properly.'
    end

    raise time_range_error if requirements_not_met?
    raise order_error if start_time > end_time
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
    time.downcase.include?('am') ? Time.parse(time) + DAY_IN_SECS : Time.parse(time)
  end

  def requirements_not_met?
    (start_time < HARD_START || end_time > HARD_END)
  end

  def time_range_error
    ArgumentError.new('Start and end times must be within given range.')
  end

  def order_error
    ArgumentError.new('Start time must come before end time.')
  end

  def valid_arguments_error
    ArgumentError.new('You must add valid arguments.')
  end

end
