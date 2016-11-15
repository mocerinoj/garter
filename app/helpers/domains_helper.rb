module DomainsHelper
  def format_nameservers(nameservers)
    nameservers.map { |n| n['name'] }.to_sentence
  end

  def icon_for_boolean(value)
    if value || value == 'yes'
      '<i class="fa fa-check-circle text-primary"></i>'.html_safe
    end
  end

  def build_domain_url(host, is_ssl)
    if is_ssl
      prefix = 'https://'
    else
      prefix = 'http://'
    end
    prefix.concat(host)
  end

  def format_mb(size)
    conv = [ 'b', 'kb', 'mb', 'gb', 'tb', 'pb', 'eb' ];
    scale = 1024;

    ndx=1
    if( size < 2*(scale**ndx)  ) then
      return "#{(size)} #{conv[ndx-1]}"
    end
    size=size.to_f
    [2,3,4,5,6,7].each do |ndx|
      if( size < 2*(scale**ndx)  ) then
        return "#{'%.3f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
      end
    end
    ndx=7
    return "#{'%.3f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
  end
end
