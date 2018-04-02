class DomainsController < ApplicationController
  http_basic_authenticate_with name: ENV['APP_USERNAME'], password: ENV['APP_PASSWORD']

  def index
    params[:all] ||= "false"

    if params[:all] == "true"
      @domains = Domain.include_latest.includes(:plesk_server)
    else
      @domains = Domain.active.hosted.include_latest.includes(:plesk_server)
    end

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = 'attachment; filename="garter-list.csv"'
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def relevant
    @domains = Domain.relevant

    respond_to do |format|
      format.html { render :index }
      format.csv do
        headers['Content-Disposition'] = 'attachment; filename="garter-relevant-list.csv"'
        headers['Content-Type'] ||= 'text/csv'
        render :index
      end
    end
  end

  def details
    @domain = Domain.find(params[:id])

    render layout: false
  end
end
