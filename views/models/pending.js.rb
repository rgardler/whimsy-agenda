#
# Provide a thin (and quite possibly unnecessary) interface to the
# Server.pending data structure.
#

class Pending
  def self.load(value)
    Server.pending = value if value
    Main.refresh()
    return value
  end

  def self.count
    self.comments.keys().length + self.approved.keys().length
  end

  def self.comments
    Server.pending ? Server.pending.comments : []
  end

  def self.approved
    Server.pending.approved
  end

  def self.rejected
    Server.pending.rejected
  end

  def self.seen
    Server.pending.seen
  end

  def self.initials
    Server.pending.initials || Server.initials
  end
end
