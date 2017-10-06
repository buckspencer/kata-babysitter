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

      @start_time = format_time(start_t.to_i)
      @end_time = format_time(end_t.to_i)
      @bed_time = format_time(bed_t.to_i)

    rescue
      raise run_time_error
    end

    raise run_time_error if inputs_improperly_formatted?(start_t, end_t, bed_t) || out_of_sequence?
  end

  def calc_payment
    [calc_pre_bed, calc_bed_to_midnight, calc_midnight_to_end].sum
  end

  def format_time time 
    time < 5 ? time + 10 : time
  end

  def run_time_error
    'Please verify that you are entering your hours properly.'
  end

end
