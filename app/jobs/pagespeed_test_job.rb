class PagespeedTestJob < ApplicationJob
  queue_as :default

  def perform(domain_id)
    domain = Domain.find(domain_id)
    domain_url = build_domain_url(domain.name, domain.is_ssl)

    test_result = GooglePageSpeedApi.new(domain_url).run_pagespeed
    return unless test_result['formattedResults'].present?

    rule_results = test_result['formattedResults']['ruleResults']
    scores = test_result['ruleGroups']
    has_viewport = rule_results['ConfigureViewport']['ruleImpact'] != 10

    PagespeedTest.create!(domain: domain,
                          timestamp: Time.current,
                          speed_score: scores['SPEED']['score'],
                          usability_score: scores['USABILITY']['score'],
                          has_viewport: has_viewport,
                          test: test_result)
  end

  def build_domain_url(host, is_ssl)
    if is_ssl
      prefix = 'https://'
    else
      prefix = 'http://'
    end
    prefix.concat(host)
  end
end
