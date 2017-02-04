require 'yaml/store'

class CommentStore
  def initialize(file_name)
    @store = YAML::Store.new(file_name)
  end

  def find(id)
    @store.transaction do
      @store[id]
    end
  end

  def all
    @store.transaction do
      @store.roots.map { |id| @store[id] }
    end
  end

  def save(comm)
    @store.transaction do
      unless comm.id
        highest_id = @store.roots.max || 0
        comm.id = highest_id + 1
      end
      @store[comm.id] = comm
    end
  end
end
