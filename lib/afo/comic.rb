module Afo
  class Comic
    include ::DataMapper::Resource

    STORAGE = File.join(::Sinatra::Base.settings.public_folder, 'comics')
    attr_accessor :file, :orig_path
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
          raise
        end
      end
    end

    protected

    def self.all_ids_asc
      Comic.all(:fields => [:id], :order => [:id.asc]).map(&:id)
    end

    private

    def save_file
      File.open(storage_path, "wb") do |f|
        f.write @file
      end
    end

    def delete_file
      File.delete(@path) rescue logger.debug "Missing file for removal, would be deleted anyway"
    end

    def storage_path
      "#{STORAGE}/#{id}.#{ext}"
    end

    def ext
      orig_path.split('.').last
    end

  end
end