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
      ids = self.class.all_ids_asc
      Comic.get ids[ids.index(self.id) + 1]
    end

    def previous
      ids = self.class.all_ids_asc
      i = ids.index(self.id) - 1
      (i < 0) ? nil : Comic.get(ids[i])
    end

    def self.get_first
      Comic.get all_ids_asc.first
    end

    def self.get_last
      Comic.get all_ids_asc.last
    end

    protected

    def self.all_ids_asc
      Comic.all(:fields => [:id], :order => [:id.asc]).map(&:id)
    end

  end
end