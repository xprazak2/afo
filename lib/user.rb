module Afo
  class User
    include DataMapper::Resource
    
    property :id, Serial
    property :username, String, :required => true
    property :password, BCryptHash, :required => true
    
  end
end