module Afo
  class Content
    include ::DataMapper::Resource

    property :id, Serial
    property :name, String, :required => true, :unique => true
    property :content, Text

    def self.get(id)
      id.is_a?(Integer) ? super : first(:name => id)
    end
  end
end