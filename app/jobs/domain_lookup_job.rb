require 'resolv'

class DomainLookupJob < ApplicationJob
  queue_as :default

  def perform(domain_id)
    domain = Domain.find(domain_id)

    nameservers = nil
    begin
      whois = Whois.whois(domain.name)
      nameservers = whois.parser.nameservers
    rescue
    end

    a_record = nil
    mx_record = nil
    a_record_lookup = Resolv::DNS.new.getresources(domain.name, Resolv::DNS::Resource::IN::A)
    a_record = a_record_lookup.first.address.to_s if a_record_lookup.present?
    mx_record_lookup = Resolv::DNS.new.getresources(domain.name, Resolv::DNS::Resource::IN::MX)
    mx_record = mx_record_lookup.first.exchange.to_s if mx_record_lookup.present?

    DomainLookup.create!(domain: domain,
                         timestamp: Time.current,
                         nameservers: nameservers,
                         a_record: a_record,
                         mx_record: mx_record)
  end
end
