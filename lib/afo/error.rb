module Afo
  class Error
    attr_accessor :message, :resource

    def initialize(opts = {})
      @message = opts[:message]
      @resource = opts[:resource]
    end

  end
end