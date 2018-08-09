if defined?(Pronto)
  module Faraday
    class Adapter
      class NetHttp < Faraday::Adapter

        def ssl_verify_mode(ssl)
          OpenSSL::SSL::VERIFY_NONE
        end
      end
    end
  end
end
