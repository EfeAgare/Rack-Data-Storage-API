class DataRegistry
  def self.add(repository, oid, size, data)
    $data[repository] ||= {}
    $data[repository][oid] = { oid: oid, size: size, data: data  }
  end

  def self.find(repository, oid)
    $data[repository][oid]
  end

  def self.delete(repository, oid)
    $data[repository].delete(oid)
  end

  def self.exists?(repository, oid)
    $data[repository]&.key?(oid)
  end
end
