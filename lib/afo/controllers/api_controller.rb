require 'rabl'
require 'application_controller'
module Afo
  class ApiController < ApplicationController
    include Afo::Rendering

    Rabl.configure do |config|
      config.include_json_root = false
      config.include_child_root = false
    end

    Rabl.register!

    not_found do
      content_type :json
      halt 404, { error: 'URL not found' }.to_json
    end

    set(:methods) do |*methods|
      condition do
        methods.map! { |method| method.to_s.upcase }
        methods.include? request.request_method
      end
    end

    before :methods => [:post, :put, :delete] do
      throw :warden, :action => '/unauthenticated_api' unless warden.authenticated?
    end
  end
end