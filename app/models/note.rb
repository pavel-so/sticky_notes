class Note
  include MongoMapper::Document
  key :message, String
  key :created_at, Time

  validates :message,
            :presence=>true,
            :length=>{:minimum=>4}
  before_create :set_time
  protected
  def set_time
    self.created_at=Time.now
  end
end

