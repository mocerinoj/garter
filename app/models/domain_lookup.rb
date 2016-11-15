class DomainLookup < ApplicationRecord
  TNT_PLESK_IPS = ['104.131.106.80',
                   '104.236.203.202',
                   '45.55.38.142',
                   '159.203.243.241',
                   '159.203.114.105',
                   '192.241.187.71']

  belongs_to :domain

  has_one :plesk_server, through: :domain

  scope :tnt_hosted, -> { where(a_record: TNT_PLESK_IPS) }
  # scope :tnt_hosted, -> { where("a_record = host(plesk_servers.primary_ip)") }

  def tnt_hosted?
    TNT_PLESK_IPS.include?(self.a_record)
  end

  def tnt_hosted_mail?
    return unless self.mx_record.present?
    self.mx_record.include?('tntsupport.net')
  end
end
