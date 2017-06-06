module IPWhitelist
  module Controller
    def self.included(base)
      base.before_action :check_ip_whitelist
    end

    def check_ip_whitelist
      if current_user && current_user.respond_to?(:ip_whitelist) && current_user.ip_whitelist.present?
        # Since requests can come through cloudflare, try that IP first.
        ip = request.headers["CF-Connecting-IP"] || request.headers["REMOTE_ADDR"]
        return if current_user.ip_whitelist.map(&:to_s).include?(ip)
        render text: "Not Authorized", status: 401
      end
    end
  end
end
