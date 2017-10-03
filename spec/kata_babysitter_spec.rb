require_relative '../lib/kata_baby_sitter'

RSpec.describe "KataBabySitter" do

  subject {KataBabySitter}

  describe 'initial test' do 

    it 'should exist' do
      expect(subject.itself.name).to eql('KataBabySitter')
    end

  end

  describe 'business logic' do 

    context 'when rates are properly defined' do 

      it { expect(subject::PRE_BED_RATE).to eql(12) }

      it { expect(subject::BED_TO_MIDNIGHT).to eql(8) }

      it { expect(subject::MIDNIGHT_TO_END).to eql(16) }

    end

  end

end