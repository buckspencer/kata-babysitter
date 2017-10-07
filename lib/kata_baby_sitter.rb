class KataBabySitter

  MIDNIGHT = 12
  HARD_START = 5 
  HARD_END = 16

  RATES = [PRE_BED = 12, BED_TO_MIDNIGHT = 8, MIDNIGHT_TO_END = 16]

  attr_reader :start_time, :end_time, :bed_time

  def initialize start_t, end_t, bed_t

    begin

      @start_time = format_time(start_t, start_t.to_i)
      @end_time = format_time(end_t, end_t.to_i)
      @bed_time = format_time(bed_t, bed_t.to_i)

    rescue NoMethodError
      raise run_time_error
    end

    raise run_time_error if out_of_sequence?
  end

  def calc_payment
    [calc_pre_bed, calc_bed_to_midnight, after_midnight].sum
  end

  def calc_pre_bed
    (bed_time - start_time) * PRE_BED
  end

  def calc_bed_to_midnight
    bed_time < MIDNIGHT ? ((end_time > MIDNIGHT ? MIDNIGHT - bed_time : end_time - bed_time) * BED_TO_MIDNIGHT) : 0
  end

  def calc_midnight_to_end 
    end_time > MIDNIGHT ? (end_time - MIDNIGHT) * MIDNIGHT_TO_END : 0
  end

  def calc_start_after_midnight
    (end_time - start_time) * MIDNIGHT_TO_END
  end

  def after_midnight
    start_time > MIDNIGHT ? calc_start_after_midnight : calc_midnight_to_end
  end

  def format_time raw, time 
    (raw.downcase.include?('am') && time < 5) ? time + 12 : time
  end

  def out_of_sequence?
    (start_time < HARD_START || end_time > HARD_END) || (bed_time > end_time) || (start_time > end_time)
  end

  def run_time_error
    'Please verify that you are entering your hours properly.'
  end

end
