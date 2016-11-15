class Domain < ApplicationRecord
  belongs_to :plesk_server

  has_many :domain_lookups
  has_many :pagespeed_tests

  has_one :last_lookup, -> { order(timestamp: :desc) }, class_name: :DomainLookup
  has_one :last_pagespeed_test, -> { order(timestamp: :desc) }, class_name: :PagespeedTest
  has_one :last_stat, -> { order(timestamp: :desc) }, class_name: :DomainStat

  scope :hosted, -> { where(hosting_type: 'vrt_hst') }
  scope :redirect, -> { where(hosting_type: 'std_fwd') }
  scope :active, -> { where(status: '0') }
  scope :ssl, -> { where(is_ssl: true) }
  scope :non_ssl, -> { where.not(is_ssl: true) }
  scope :responsive, -> { includes(:last_pagespeed_test).where(pagespeed_tests: { has_viewport: true }) }

  after_create :get_stats, :run_tests

  def self.lookupable
    active.hosted.where.not(id: DomainLookup.where("timestamp > ?", 7.days.ago).pluck(:domain_id))
  end

  def self.pagespeedable
    active.hosted.where.not(id: PagespeedTest.where("timestamp > ?", 30.days.ago).pluck(:domain_id))
  end

  def self.statable
    active.hosted.where.not(id: DomainStat.where("timestamp > ?", 30.days.ago).pluck(:domain_id))
  end

  def self.relevant
    active.hosted.
    includes(:plesk_server, :last_lookup, :last_pagespeed_test).
    where(domain_lookups: { a_record: DomainLookup::TNT_PLESK_IPS })
  end

  private

  def get_stats
    DomainLookup.perform_now(id)
    DomainStat.perform_now(id)
  end

  def run_tests
    PagespeedTest.perform_now(id)
  end
end
