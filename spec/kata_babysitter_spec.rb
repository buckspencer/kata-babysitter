require 'pry'
require_relative '../lib/kata_baby_sitter'

RSpec.describe 'KataBabySitter' do
  let(:start_time)      { '6pm' }
  let(:end_time)        { '3am' }
  let(:bed_time)        { '9pm' }
  let(:run_time_error)  {'Please verify that you are entering your hours properly.'}

  subject { KataBabySitter.new(start_time, end_time, bed_time) }

  describe 'business logic' do


      it { expect(KataBabySitter::PRE_BED).to eql(12) }

      it { expect(KataBabySitter::BED_TO_MIDNIGHT).to eql(8) }

      it { expect(KataBabySitter::MIDNIGHT_TO_END).to eql(16) } 

      it { expect(KataBabySitter::MIDNIGHT).to eql(12) }  

      it { expect(KataBabySitter::HARD_START).to eql(5) }

      it { expect(KataBabySitter::HARD_END).to eql(16) }

    context 'with incorrectly given arguments' do 

      context 'when arguments are correctly given' do
        it { expect{ subject.calc_payment }.not_to raise_error }
      end

      context 'when nils are passed' do 
        let(:start_time) { nil }
        let(:end_time)   { nil }
        let(:bed_time)   { nil }

        it { expect{ subject.calc_payment }.to raise_error(RuntimeError, run_time_error) }
      end

      context 'when numbers are passed' do 
        let(:start_time) { 9 }
        let(:end_time)   { 9 }
        let(:bed_time)   { 9 }

        it { expect{ subject.calc_payment }.to raise_error(RuntimeError, run_time_error) }
      end

      context 'when words are passed' do 
        let(:start_time) { 'hey' }
        let(:end_time)   { 'hey' }
        let(:bed_time)   { 'hey' }

        it { expect{ subject.calc_payment }.to raise_error(RuntimeError, run_time_error) }
      end

      context 'when a decimal is passed' do 
        let(:end_time)   { '2.5am' }

        it { expect(subject.calc_payment).to eql(92) }
      end

      context 'when start_time is later than end_time' do
        let(:end_time)   { '6am' }

        it { expect{ subject.calc_payment }.to raise_error(RuntimeError, run_time_error) }
      end

      context 'when end_time is before than start_time' do 
        let(:end_time)   { '5pm' }

        it { expect{ subject.calc_payment }.to raise_error(RuntimeError, run_time_error) }
      end

      context 'when end is before bed' do 
        let(:end_time)   { '8pm' }

        it { expect{ subject.calc_payment }.to raise_error(RuntimeError, run_time_error) }
      end

    end

  end

  describe 'calc_payment' do 

    context 'with expected input' do
      it { expect(subject.calc_payment).to eql(108) }
    end

    context 'when end is before midnight' do 
      let(:end_time)   { '11pm' }

      it { expect(subject.calc_payment).to eql(52) }
    end

    context 'when end is at midnight' do 
      let(:end_time)   { '12am' }

      it { expect(subject.calc_payment).to eql(60) }
    end

    context 'when bedtime is at midnight' do 
      let(:bed_time)   { '12am' }

      it { expect(subject.calc_payment).to eql(120) }
    end

    context 'when bedtime and endtime is at midnight' do 
      let(:bed_time)   { '12am' }
      let(:end_time)   { '12am' }

      it { expect(subject.calc_payment).to eql(72) }
    end

    context 'when start_time is at midnight' do 
      let(:start_time)   { '12am' }
      let(:bed_time)     { '1am'  }
      let(:end_time)     { '4am'  }

      it { expect(subject.calc_payment).to eql(76) }
    end   

  end

  describe 'format_time' do
    let(:number) { 15 }

    context 'when contains am' do 
      let(:time) { '3am' }

      it { expect(subject.format_time(time, time.to_i)).to eql(number) }
    end

    context 'when contains pm' do
      let(:pm_number) { time.to_i }
      let(:time) { '3pm' }

      it { expect(subject.format_time(time, time.to_i)).to eql(pm_number) }
    end

    context 'when contains AM' do
      let(:time) { '3AM' }

      it { expect(subject.format_time(time, time.to_i)).to eql(number) }
    end
  end

end