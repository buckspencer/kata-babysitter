require 'pry'
require_relative '../lib/kata_baby_sitter'

RSpec.describe "KataBabySitter" do
  let(:start_time) {'6pm'}
  let(:end_time)   {'3am'}
  let(:bed_time)   {'9pm'}

  subject { KataBabySitter.new(start_time, end_time, bed_time) }

  describe 'business logic' do 

      it { expect(KataBabySitter::PRE_BED).to eql(12) } #36

      it { expect(KataBabySitter::BED_TO_MIDNIGHT).to eql(8) } #24

      it { expect(KataBabySitter::MIDNIGHT_TO_END).to eql(16) } #48 

      it { expect(KataBabySitter::HARD_START.hour).to eql(17) }

      it { expect(KataBabySitter::HARD_END.hour).to eql(4) }

  end


  describe 'calc_payment' do 
    

    before {subject.calc_payment}


    context 'working correctly' do 
      it { is_expected.to eql(108)}
    end


    context 'error handling' do 
      context 'when arguments are correctly given' do 
        it { is_expected.not_to raise_error }
      end


      context 'when start_time is later than end_time' do 
        let(:end_time)   { '6am'}

        it { is_expected.to raise_error(ArgumentError, "Start and end times must be within given range.") }
      end

      context 'when end_time is before than start_time' do 
        let(:end_time)   { '5pm'}

        it { is_expected.to raise_error(ArgumentError, "Start time must come before end time.") }
      end
    end
  end


  describe 'calc_pre_bed' do 

    context 'when proper arguments' do
      it { expect{subject.calc_pre_bed}.to eql(36)}
    end


  end

  describe 'calc_bed_to_midnight' do 

    subject { KataBabySitter.new.calc_bed_to_midnight(bed_time)}

    context 'when proper arguments' do 
      it { expect(subject).to eql(24)}
    end

  end

  describe 'calc_midnight_to_end' do 

    subject { KataBabySitter.new.calc_midnight_to_end(end_time)}

    context 'when proper arguments' do 
      it { expect(subject).to eql(48)}
    end

  end

  describe 'format_time' do 

    subject { KataBabySitter.new.format_time(time)}

    context 'when contains am' do 
      let(:time) { '3am' }

      it { expect(subject).to eql(Time.parse(time) + 86400) }
    end

    context 'when contains pm' do 
      let(:time) { '3pm' }

      it { expect(subject).to eql(Time.parse(time)) }
    end
  end

end