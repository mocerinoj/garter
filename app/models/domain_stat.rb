class DomainStat < ApplicationRecord
  belongs_to :domain

  scope :recent_last_two, -> { where('timestamp > ?', 3.weeks.ago).order(timestamp: :desc).limit(2) }

  def self.compare_disk_usage
    ((first.disk_usage['httpdocs'].to_f / last.disk_usage['httpdocs'].to_f) * 100)
  end

  def self.compare_traffic
    ((first.disk_usage['traffic'].to_f / last.disk_usage['traffic'].to_f) * 100)
  end

  def self.disk_space_concern?
    compare_disk_usage > 100
  end

  def self.traffic_concern?
    compare_traffic > 100
  end
end
