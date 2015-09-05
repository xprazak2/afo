module Afo
  class User
    include DataMapper::Resource
    
    self.raise_on_save_failure = true

    property :id, Serial
    property :username, String, :required => true
    property :password, BCryptHash, :required => true
    
    def to_initial
      @username[0].capitalize << "."
    end
    
  end
end