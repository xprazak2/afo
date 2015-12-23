module Afo
  class User
    include ::DataMapper::Resource

    self.raise_on_save_failure = true

    property :id, Serial
    property :name, String, :required => true, :unique => true
    property :password, BCryptHash, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime

    validates_length_of :name, :min => 4
    validates_length_of :password, :min => 4

    has n, :comics

    def to_initial
      @name[0].respond_to?(:capitalize) ? @name[0].capitalize << "." : @name[0]
    end

    def to_s
      to_initial
    end
  end
end