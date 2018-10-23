# frozen_string_literal: true

require 'grpc_kit/interceptors/streaming'

module GrpcKit
  module Interceptors
    module Client
      class ClientStreamer < Streaming
        private

        def invoke(interceptor, call, metadata)
          # We don't need a `:requests` parameter but,
          # it shuoldn't remove from paramters due to having a compatibility of grpc gem.
          interceptor.client_streamer(requests: nil, call: call, method: call.method, metadata: metadata) do
            yield(call, metadata)
          end
        end
      end
    end

    module Server
      class ClientStreamer < Streaming
        def invoke(interceptor, call)
          interceptor.client_streamer(call: call, method: call.method) do
            yield(call)
          end
        end
      end
    end
  end
end
