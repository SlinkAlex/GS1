require "uri"
require "json"
require "net/http"

module Requests

    def make_get_request(uri)
        url = URI(uri)

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        # Request headers
        request["Content-Type"] = "application/json"
        request['Cache-Control'] = 'no-cache'
        request['APIKey'] = 'e7159b3ec4574221afb8909128e0e32b'
        return https.request(request).body
    end

    def make_post_request(uri, body)
        url = URI(uri)

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        # Request headers
        request["Content-Type"] = "application/json"
        request['Cache-Control'] = 'no-cache'
        request['APIKey'] = 'e7159b3ec4574221afb8909128e0e32b'
        request.body = JSON.dump(body)
        return https.request(request).body
    end
end