module Afo
  class User
    include ::DataMapper::Resource
    
    self.raise_on_save_failure = true

    property :id, Serial
    property :username, String, :required => true, :unique => true
    property :password, BCryptHash, :required => true

    validates_length_of :username, :min => 4
    validates_length_of :password, :min => 4

    has n, :comics
    
    def to_initial
      @username[0].respond_to?(:capitalize) ? @username[0].capitalize << "." : @username[0]
    end
    
    def to_s
      to_initial
    end
  end
end