module Afo
  class Comic
    include ::DataMapper::Resource

    STORAGE = File.join(::Sinatra::Base.settings.public_folder, 'comics')
    attr_accessor :file, :name
    property :id, Serial
    property :title, String, :required => true
    property :path, FilePath #make it required in the future?
    property :created_at, DateTime
    property :updated_at, DateTime

    belongs_to :user, :required => false
    alias uploaded_by user

    def next
      ids = self.class.all_ids_asc
      Comic.get ids[ids.index(self.id) + 1]
    end

    def previous
      ids = self.class.all_ids_asc
      i = ids.index(self.id) - 1
      (i < 0) ? nil : Comic.get(ids[i])
    end

    def save
      logger.debug "Saving file: #{title}, please wait..."
      Comic.transaction do |t|
        begin
          raise errors.values.join(', ') unless super
          save_file
          self.path = storage_path.to_s
          raise errors.values.join(', ') unless super
        rescue => e
          logger.error "Failed to save file: #{title}"
          logger.error e.message
          delete_file if self.path
          logger.debug e.backtrace.join("\n\t")
          t.rollback
          raise e.message
        end
      end
    end

    def destroy
      Comic.transaction do |t|
        begin
          delete_file
          super
        rescue => e
          logger.error "Error during removal of the file: #{path}."
          logger.debug e.backtrace.join("\n\t")
          t.rollback
          raise e.message
        end
      end
    end

    def self.get(id)
      comic = super id
      comic.load_file if comic
      comic
    end

    def self.load_all
      comics = Comic.all
      Comic.load_files comics
    end

    def self.all_ids_asc
      Comic.all(:fields => [:id], :order => [:id.asc]).map(&:id)
    end

    def load_file
      begin
        @file = Base64.encode64(File.read(@path))
      rescue => e
        logger.error e.message
        logger.debug e.backtrace.join("\n\t")
      end
    end

    def self.load_files(comics)
      comics.each { |c| c.load_file }
    end

    %w(created_at updated_at).each do |method|
      define_method "pretty_#{method}" do
        time = instance_variable_get("@#{method}")
        time ? time.strftime("%d %b %Y, %H:%M:%S %Z") : nil
      end
    end

    private

    def save_file
      File.open(storage_path, "wb") do |f|
        f.write Base64.decode64(@file)
      end
    end

    def delete_file
      File.delete(@path) rescue logger.debug "Missing file for removal, would be deleted anyway"
    end

    def storage_path
      "#{STORAGE}/#{id}.#{ext}"
    end

    def ext
      name.split('.').last
    end
  end
end