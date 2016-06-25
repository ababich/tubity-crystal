class TubityUrl

  KEY_URL  = "tubity:url:"
  KEY_HASH = "tubity:hash:"

  URI_REGEX = /https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?/

  def self.shorten(redis, url)
    return "" unless url.to_s.match(URI_REGEX)

    hash = redis.get(KEY_URL + url)

    unless hash
      hash = Counter.get_hash(redis)

      redis.set(KEY_HASH + hash, url)
      redis.set(KEY_URL + url, hash)
    end

    hash
  end


  def self.expand(redis, hash)
    redis.get(KEY_HASH + hash) || ""
  end
end