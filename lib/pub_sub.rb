require 'net/http'

module PubSub
  class << self
    def server_url
      "#{ServicesSettings.pubsub.mount_point}"
    end

    def server_uri
      @server_uri ||= URI.parse(server_url)
    end

    def publish(channel, data)
      Net::HTTP.post_form(server_uri, :message => JSON.dump(:channel => channel, :data => data))
    rescue Errno::ECONNREFUSED
      false
    end
  end
end
