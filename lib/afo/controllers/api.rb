require 'rabl'
module Afo
  class Api < ::Sinatra::Base
    include Afo::Rendering

    Rabl.configure do |config|
      config.include_json_root = false
      config.include_child_root = false
    end

    Rabl.register!
  end
end