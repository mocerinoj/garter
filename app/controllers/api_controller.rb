class ApiController < ApplicationController
  def goto_plesk
    return unless params[:domain].present?

    domain = Domain.find_by(name: params[:domain])
    return unless domain

    redirect_to "https://#{domain.plesk_server.host}:8443/"
  end
end
