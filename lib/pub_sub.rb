require 'net/http'

module PubSub
  class << self
    attr_accessor :current_host

    def mount_url
      "http://#{current_host}:3500/pubsub"
    end

    def server_peer_uri
      @server_peer_uri ||= URI.parse("http://127.0.0.1:3500/pubsub")
    end

    def publish(channel, data)
      Net::HTTP.post_form(server_peer_uri, :message => JSON.dump(:channel => channel, :data => data))
    rescue Errno::ECONNREFUSED
      false
    end
  end
end
