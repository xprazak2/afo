module Afo
  module Rendering

    def find_resource
      if params[:id]
        resource_class.get(params[:id]) || render_error(
          "could not find #{file_name.chop} with id #{params[:id]}",
           resource_class.to_s, 422)
      else
        render_error("could not find #{file_name.chop}, no id given")
      end
    end

    def render_resource
      path = file_path "show"
      rabl path, :format => :json
    end

    def render_index
      path = file_path "index"
      rabl path, :format => :json
    end

    def render_validation_errors
      path = file_path "error"
      halt(422, rabl(path, :format => :json))
    end

    def render_error(message, resource_name = resource_class.to_s , code = 422)
      @error = Error.new(:message => message, :resource => resource_name)
      halt(code, rabl(:'common/error', :format => :json))
    end

    protected

    def resource_class
      modularize(file_name.chop.capitalize).constantize
    end

    def file_name
      self.class.to_s.demodulize.underscore.split('_').first
    end

    def file_path(action)
      "#{file_name}/#{action}".to_sym
    end

    def modularize(klass)
      "Afo::#{klass}"
    end
  end
end