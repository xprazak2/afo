require 'bcrypt'

module Afo
  class User
    include ::DataMapper::Resource
    include BCrypt

    self.raise_on_save_failure = true

    property :id, Serial
    property :name, String, :required => true, :unique => true
    property :password, BCryptHash, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime
    property :last_login, DateTime

    validates_length_of :name, :min => 4
    validates_length_of :password, :min => 4

    has n, :comics

    def to_initial
      @name[0].respond_to?(:capitalize) ? @name[0].capitalize << "." : @name[0]
    end

    def to_s
      to_initial
    end

    def self.authenticate(username, pass)
      user = first(:name => username)
      user && ::BCrypt::Password.new(user.password).is_password?(pass) ? user : nil
    end

    def update(params)
      #workaround for possible bug in DataMapper for hashed fields
      self.password = params[:password] || self.password
      save
    end
  end
end