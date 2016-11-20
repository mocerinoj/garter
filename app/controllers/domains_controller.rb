class DomainsController < ApplicationController
  http_basic_authenticate_with name: ENV['APP_USERNAME'], password: ENV['APP_PASSWORD']

  def index
    @domains = Domain.includes(:plesk_server, :last_lookup, :last_pagespeed_test)

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
      format.html
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
