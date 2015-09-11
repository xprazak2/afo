module Afo
  class Comic 
    include ::DataMapper::Resource

    property :id, Serial
    property :title, String
    property :path, FilePath, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime

    belongs_to :user
    alias uploaded_by user

    def next
      ids = Comic.all.map(&:id).sort
      Comic.get ids[ids.index(self.id) + 1]
    end

    def previous
      ids = Comic.all.map(&:id).sort
      i = ids.index(self.id) - 1
      (i < 0) ? nil : Comic.get(ids[i])
    end

    def log_me
      logger.info "logging"
    end
  end
end