require "rails_helper"

describe IPWhitelist::Controller, type: :request do
  it "Blocks all IPs except whitelist if a whitelist exists" do
    ::ApplicationController.class_eval do
      def current_user
        User.new(ip_whitelist: ["70.184.237.0"])
      end
    end

    get "/", { headers: { "REMOTE_ADDR": "192.168.1.0"} }
    expect(response).to have_http_status(401)
  end

  it "Allow IPs in the whitelist" do
    ::ApplicationController.class_eval do
      def current_user
        User.new(ip_whitelist: ["70.184.237.19"])
      end
    end

    get "/", { headers: { "REMOTE_ADDR": "70.184.237.19"} }
    expect(response).to have_http_status(200)
  end

  it "Allow IPs in a range" do
    ::ApplicationController.class_eval do
      def current_user
        User.new(ip_whitelist: ["70.184.237.0/24"])
      end
    end

    get "/", { headers: { "REMOTE_ADDR": "70.184.237.19"} }
    expect(response).to have_http_status(200)
  end

  it "Allow all IPs if a whitelist does not exist" do

    ::ApplicationController.class_eval do
      def current_user
        User.new(ip_whitelist: nil)
      end
    end

    get "/", { headers: { "REMOTE_ADDR": "1.2.3.4"} }
    expect(response).to have_http_status(200)
  end
end
