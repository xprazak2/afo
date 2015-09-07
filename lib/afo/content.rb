module Afo
  class Content
    include ::DataMapper::Resource

    property :id, Serial
    property :name, String, :required => true
    property :content, Text
    
  end
end