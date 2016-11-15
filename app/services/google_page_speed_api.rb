class GooglePageSpeedApi
  include HTTParty

  base_uri 'https://www.googleapis.com/pagespeedonline/v2'

  def initialize(url, screenshot = true, strategy = 'mobile')
    @options = { query: { url: url,
                          screenshot: screenshot,
                          strategy: strategy,
                          key: ENV['GOOGLE_PAGESPEED_API_KEY']} }
  end

  def run_pagespeed
    self.class.get('/runPagespeed', @options)
  end
end
