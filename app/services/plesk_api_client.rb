# Copyright 1999-2016. Parallels IP Holdings GmbH. All Rights Reserved.

require 'net/http'
require 'net/https'

class PleskApiClient

  def initialize(params)
    @host = params[:host]
    @port = params[:port] || 8443
    @protocol = params[:protocol] || 'https'
    @login = params[:login] || 'admin'
    @password = params[:password] || ENV['PLESK_PASSWORD']
  end

  def set_secret_key(secret_key)
    @secret_key = secret_key
  end

  def request(body)
    http_request = Net::HTTP::Post.new('/enterprise/control/agent.php')
    http_request.body = body
    http_request.content_type = 'text/xml'
    http_request.add_field 'HTTP_PRETTY_PRINT', 'TRUE'

    if @secret_key
      http_request.add_field 'KEY', @secret_key
    else
      http_request.add_field 'HTTP_AUTH_LOGIN', @login
      http_request.add_field 'HTTP_AUTH_PASSWD', @password
    end

    http = Net::HTTP.new(@host, @port)
    http.read_timeout = 240
    if 'https' == @protocol
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    response = http.start{ |http| http.request(http_request) }
    format_response(response)
  end

  def format_response(response)
    Hash.from_xml(response.body)
  end

  def get_domains
    request = <<eof
<packet>
  <webspace>
    <get>
      <filter>
      </filter>
      <dataset>
        <gen_info/>
        <hosting/>
      </dataset>
    </get>
  </webspace>
</packet>
eof
    request(request)
  end

  def get_domain_stats(id)
    request = <<eof
<packet>
  <webspace>
    <get>
      <filter>
        <id>#{id}</id>
      </filter>
      <dataset>
        <stat/>
        <disk_usage/>
      </dataset>
    </get>
  </webspace>
</packet>
eof
    request(request)
  end

  def get_domain(id)
    request = <<eof
<packet>
  <webspace>
    <get>
      <filter>
        <id>#{id}</id>
      </filter>
      <dataset>
        <gen_info/>
        <hosting/>
        <prefs/>
        <stat/>
        <disk_usage/>
      </dataset>
    </get>
  </webspace>
</packet>
eof
    request(request)
  end

  def get_server
    request = <<eof
<packet>
  <server>
    <get>
      <gen_info/>
      <stat/>
    </get>
  </server>
</packet>
eof
    request(request)
  end

  def get_server_stats
    request = <<eof
<packet>
  <server>
    <get>
      <stat/>
    </get>
  </server>
</packet>
eof
    request(request)
  end

  def get_server_services
    request = <<eof
<packet>
  <server>
    <get>
      <services_state/>
    </get>
  </server>
</packet>
eof
    request(request)
  end

end
