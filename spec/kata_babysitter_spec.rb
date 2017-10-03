require_relative '../lib/kata_baby_sitter'

RSpec.describe "KataBabySitter" do

  it 'should exist' do
    expect(KataBabySitter.itself.name).to eql('KataBabySitter')
  end

end