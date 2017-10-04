require_relative '../lib/kata_baby_sitter'

RSpec.describe "KataBabySitter" do

  subject {KataBabySitter}

  describe 'potential overkill test' do 

    it 'should exist' do
      expect(subject.itself.name).to eql('KataBabySitter')
    end

  end

  describe 'business logic' do 

      it { expect(subject::PRE_BED).to eql(12) }

      it { expect(subject::BED_TO_MIDNIGHT).to eql(8) }

      it { expect(subject::MIDNIGHT_TO_END).to eql(16) }

      it { expect(subject::HARD_START).to eql(17) }

      it { expect(subject::HARD_END).to eql(4) }

  end


  describe 'calc_payment' do 
    let(:start_time) { '6pm' }
    let(:end_time)   { '3am'}
    let(:bed_time)   {'9pm'}

    subject { KataBabySitter.calc_payment(start_time, end_time, bed_time) }

    # it { expect(subject).to eql(108) }
    it { expect(subject).to eql('hello')}
  end

end