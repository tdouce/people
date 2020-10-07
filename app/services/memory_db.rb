# NOTE: TKD 2020/10/06
# This is a class used to function as a database for the purpose of the take home. According to the
# instructions, the take home suggested not using a persistent datastore.
class MemoryDb
  def self.reset
    $memory_db = {records: []}
  end

  def self.add_record(record:)
    $memory_db[:records] << record
  end
end