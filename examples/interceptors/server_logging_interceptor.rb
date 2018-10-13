# frozen_string_literal: true

require 'grpc_kit'

class LoggingInterceptor < GRPC::ServerInterceptor
  def request_response(request: nil, call: nil, method: nil)
    now = Time.now.to_i
    GrpcKit.logger.info("Started request #{request}, method=#{method.name}, service_name=#{method.receiver.class.service_name}")
    yield.tap do
      GrpcKit.logger.info("Elapsed Time: #{Time.now.to_i - now}")
    end
  end

  def client_streamer(call: nil, method: nil)
    yield
  end

  def server_streamer(request: nil, call: nil, method: nil)
    yield
  end

  def bidi_streamer(requests: nil, call: nil, method: nil)
    yield
  end
end
