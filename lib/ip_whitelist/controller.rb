module IPWhitelist
  module Controller
    def check_ip_whitelist
      if current_user && current_user.respond_to?(:ip_whitelist) && current_user.ip_whitelist.present?
        # Since requests can come through cloudflare, try that IP first.

        Rails.logger.info("All headers:\n#{request.headers.keys.join("\n")}")

        ip = IPAddr.new(request.headers["CF-Connecting-IP"] || request.headers["REMOTE_ADDR"])

        return if current_user.ip_whitelist.detect{ |ip_or_range|
          # Check if the IP is equal to the whitelisted IP, or is within the
          # whitelisted IP range.
          (ip_or_range.is_a?(IPAddr) ? ip_or_range : IPAddr.new(ip_or_range)) === ip
        }

        if redirect = IPWhitelist.configuration.redirect
          redirect_to redirect
        else
          render text: "Not Authorized", status: 401
        end
      end
    end
  end
end
