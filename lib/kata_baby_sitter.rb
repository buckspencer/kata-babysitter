require 'time'

module KataBabySitter

  ## pay rates
  PRE_BED = 12
  BED_TO_MIDNIGHT = 8
  MIDNIGHT_TO_END = 16

  ## cut off range
  HARD_START = 17
  HARD_END = 4

  def self.calc_payment start_time, end_time, bed_time
    start = format_time(start_time)
    finish = 
    binding.pry 
  end


  def self.format_time time
    time.include?('am') ? Time.parse(time) + 86400 : Time.parse(time)
  end

end