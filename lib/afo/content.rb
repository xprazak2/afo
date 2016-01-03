module Afo
  class Content
    include ::DataMapper::Resource

    property :id, Serial
    property :title, String, :required => true, :unique => true
    property :content, Text

    def self.get(id)
      (Integer(id) rescue false) ? super : first(:title => id)
    end
  end
end