class Report < ActiveRecord::Base
  # attr_accessible :title, :body

  def initialize
    @mess = @mess.try(:clear) || []
    super
  end

  def complete?
    #@mess[1] && @mess[3] && @mess[4]
    ([1,3,4] & @mess).size == 3
  end

  def messages
    @mess
  end

  def add_mess(mess)
    @mess << mess
  end


end


