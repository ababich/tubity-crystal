require "./kml/*"
require "kemal"
require "redis"
require "json"

module Kml

  redis = Redis.new

  post "/s" do |env|
    url = env.params.json["url"] as String

    env.response.content_type = "application/json"
    {
      url: url,
      shorten_url: "http://" + env.request.headers["Host"] + "/" + TubityUrl.shorten(redis, url)
    }.to_json
  end

  get "/:hash" do |env|
    hash = env.params.url["hash"]

    env.redirect TubityUrl.expand(redis, hash)
  end

end

Kemal.run
