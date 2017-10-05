require 'pry'
require_relative '../lib/kata_baby_sitter'

RSpec.describe 'KataBabySitter' do
  let(:start_time) { '6pm' }
  let(:end_time)   { '3am' }
  let(:bed_time)   { '9pm' }

  subject { KataBabySitter.new(start_time, end_time, bed_time) }

  describe 'business logic' do

      it { expect(KataBabySitter::DAY_IN_SECS).to eql(86_400)}

      it { expect(KataBabySitter::MIDNIGHT).to eql(24)}  

      it { expect(KataBabySitter::PRE_BED).to eql(12) }

      it { expect(KataBabySitter::BED_TO_MIDNIGHT).to eql(8) }

      it { expect(KataBabySitter::MIDNIGHT_TO_END).to eql(16) } 

      it { expect(KataBabySitter::HARD_START.hour).to eql(17) }

      it { expect(KataBabySitter::HARD_END.hour).to eql(4) }

    context 'error handling' do 
      context 'when arguments are correctly given' do
        it { expect{ subject }.not_to raise_error }
      end

      context 'when nils are passed' do 
        let(:start_time) { nil }
        let(:end_time)   { nil }
        let(:bed_time)   { nil }

        it { expect{ subject }.to raise_error(RuntimeError, 'Please verify that you are entering your hours properly.') }
      end


      context 'when start_time is later than end_time' do
        let(:end_time)   { '6am' }

        it { expect{ subject }.to raise_error(ArgumentError, "Start and end times must be within given range.") }
      end

      context 'when end_time is before than start_time' do 
        let(:end_time)   { '5pm' }

        it { expect{ subject }.to raise_error(ArgumentError, "Start time must come before end time.") }
      end
    end

  end



  describe 'calc_payment' do 

    context 'working correctly' do
      it { expect(subject.calc_payment).to eql(108) }
    end



  end


  describe 'calc_pre_bed' do

    context 'when proper arguments' do
      it { expect(subject.calc_pre_bed).to eql(36) }
    end

  end

  describe 'calc_bed_to_midnight' do

    context 'when proper arguments' do 
      it { expect(subject.calc_bed_to_midnight).to eql(24) }
    end

  end

  describe 'calc_midnight_to_end' do

    context 'when proper arguments' do 
      it { expect(subject.calc_midnight_to_end).to eql(48) }
    end

  end

  describe 'format_time' do

    context 'when contains am' do 
      let(:time) { '3am' }

      it { expect(subject.format_time(time)).to eql(Time.parse(time) + KataBabySitter::DAY_IN_SECS) }
    end

    context 'when contains pm' do
      let(:time) { '3pm' }

      it { expect(subject.format_time(time)).to eql(Time.parse(time)) }
    end

    context 'when contains AM' do
      let!(:time) { '3AM' }

      it { expect(subject.format_time(time)).to eql(Time.parse(time) + KataBabySitter::DAY_IN_SECS) }
    end
  end

end