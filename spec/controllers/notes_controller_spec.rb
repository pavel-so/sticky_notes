require 'spec_helper'


messages=["message 1", "message 2"]
describe NotesController do

  before(:each) do

    @note1=Note.create!(:message=>messages[0])
    @note2=Note.create!(:message=>messages[1])
  end
  after(:each) do
    Note.destroy_all
  end

  describe "GET 'index' with js" do
    before(:each) do
      xhr :get, :index
    end
    it "should be successful" do
      response.should be_success
    end
    messages.each do |msg|
      it "should contain '#{msg}'" do
        response.body.should =~ Regexp.new(msg)
      end
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it 'should contain form with id new_note' do
      get 'new'
      response.body.should =~ /new_note/ and response.body.should =~ /form/
    end
  end

  describe "post 'create'" do
    before(:each) do
      @attr = {:message => "message test"}
    end
    it "should be successful" do
      xhr :post, :create
      response.should be_success
    end
    it 'should create a note' do
      lambda do
        xhr :post, :create, :note=>@attr
      end.should change(Note, :count)
    end
    it 'should not create an empty a note' do
      lambda do
        xhr :post, :create, :note=>{:message=>''}
      end.should_not change(Note, :count).by(1)
    end
  end

  describe "get 'edit'" do
    it "should be successful" do
      get 'edit', :id=>@note1.id
      response.should be_success
    end
    it 'should contain form with id new_note' do
      get 'edit', :id=>@note1.id
      response.body.should =~ /edit_note/ and response.body.should =~ /form/
    end
  end

  describe "put 'update'" do
    it "should be successful" do
      xhr :put, :update, :id=>@note1.id
      response.should be_success
    end
    describe 'success' do
      it "should update note" do
        n=Note.create!(:message=>'old message')
        lambda do
          xhr :put, :update, :id=>n.id, :note=>{:message=>"new message"}
          n.reload
        end.should change(n, :message)
      end
    end
    describe 'failure' do
      it "should not update note with empty message" do
        n=Note.create!(:message=>'old message')
        lambda do
          xhr :put, :update, :id=>n.id, :note=>{:message=>""}
          n.reload
        end.should_not change(n, :message)
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
      xhr :get, :show, :id=>@note1.id
    end
    it "should be successful" do
      response.should be_success
    end
    it 'should render given note id' do
      response.body.should =~ Regexp.new("#{@note1.id}")
    end
  end

  describe "Delete note" do
    it "should be successful" do
      xhr :delete, :destroy, :id=>@note1.id
      response.should be_success
    end
    it "should delete given note" do
      lambda do
        xhr :delete, :destroy, :id=>@note1.id
      end.should change(Note, :count).by(-1)
    end
  end
end

