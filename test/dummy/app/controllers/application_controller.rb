require "rails_hq_ip_whitelist"
class ApplicationController < ActionController::Base
  include IPWhitelist::Controller
  protect_from_forgery with: :exception

  def main
    render plain: "OK"
  end
end
