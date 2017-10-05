require 'pry'
require_relative '../lib/kata_baby_sitter'

RSpec.describe "KataBabySitter" do

  subject {KataBabySitter}

  describe 'potential overkill test' do 

    it 'should exist' do
      expect(subject.itself.name).to eql('KataBabySitter')
    end

  end

  describe 'business logic' do 

      it { expect(subject::PRE_BED).to eql(12) } #36

      it { expect(subject::BED_TO_MIDNIGHT).to eql(8) } #24

      it { expect(subject::MIDNIGHT_TO_END).to eql(16) } #48 

      it { expect(subject::HARD_START.hour).to eql(17) }

      it { expect(subject::HARD_END.hour).to eql(4) }

  end


  describe 'calc_payment' do 
    let(:start_time) {'6pm'}
    let(:bed_time)   {'9pm'}
    let(:end_time)   {'3am'}

    subject { KataBabySitter.calc_payment(start_time, end_time, bed_time) }


    context 'working correctly' do 
      it { expect(subject).to eql(108)}
    end


    context 'error handling' do 
      context 'when arguments are correctly given' do 
        it { expect{subject}.not_to raise_error }
      end


      context 'when start_time is later than end_time' do 
        let(:end_time)   { '6am'}

        it { expect{subject}.to raise_error(ArgumentError, "Start and end times must be within given range.") }
      end

      context 'when end_time is before than start_time' do 
        let(:end_time)   { '5pm'}

        it { expect{subject}.to raise_error(ArgumentError, "Start time must come before end time.") }
      end
    end

  end

  describe 'calc_pre_bed' do 
    let(:start_time) {'6pm'}
    let(:bed_time)   {'9pm'}

    subject { KataBabySitter.calc_pre_bed(start_time, bed_time)}

    context 'when proper arguments' do 
      it { expect(subject).to eql(36)}
    end


  end

  describe 'calc_bed_to_midnight' do 
    let(:bed_time)   {'9pm'}

    subject { KataBabySitter.calc_bed_to_midnight(bed_time)}

    context 'when proper arguments' do 
      it { expect(subject).to eql(24)}
    end

  end

  describe 'format_time' do 

    subject { KataBabySitter.format_time(time)}

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