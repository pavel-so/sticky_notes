require 'spec_helper'


describe Note do
  before(:each) do
    @attr={:message=>'test message'}
  end
  it 'should create an instance with given attributes' do
    Note.create!(@attr)
  end
  it 'should validate message presence' do
    note_without_message=Note.new(:message=>nil)
    note_without_message.should_not be_valid
  end
  4.upto(300) do |num|
    it "should have message longer than #{num} charachters" do
       note_with_message=Note.new(:message=>'a'*num)
       note_with_message.should be_valid
    end
  end
  1.upto(3) do |num|
    it "should not have message less than #{num} charachters" do
      note_with_short_message=Note.new(:message=>'a'*num)
      note_with_short_message.should_not be_valid
    end
  end

  it 'should set created_at before create' do
    note=Note.create!(@attr)
    note.created_at.should_not be_nil
  end

end

