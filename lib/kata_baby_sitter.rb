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
      raise run_time_error
    end

    raise run_time_error if inputs_improperly_formatted? || out_of_sequence?
  end

  def calc_payment
    [calc_pre_bed, calc_bed_to_midnight, calc_midnight_to_end].sum
  end

  def calc_pre_bed
    (bed_time.hour - start_time.hour) * PRE_BED
  end

  def calc_bed_to_midnight
    ( end_time.day > Time.now.day ? (MIDNIGHT - bed_time.hour) : (end_time.hour - bed_time.hour) ) * BED_TO_MIDNIGHT
  end

  def calc_midnight_to_end
    end_time.day > Time.now.day ? end_time.hour * MIDNIGHT_TO_END : 0  
  end

  def format_time time
    time.downcase.include?('am') ? Time.parse(time) + DAY_IN_SECS : Time.parse(time)
  end

  def inputs_improperly_formatted?
    [start_time.hour, end_time.hour, bed_time.hour].include?('.')
  end

  def out_of_sequence?
    (start_time < HARD_START || end_time > HARD_END) || (bed_time > end_time) || (start_time > end_time)
  end

  def run_time_error
    'Please verify that you are entering your hours properly.'
  end

end
