require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      p req.cookies
      content = req.cookies.select{ |c| c.name == "_rails_lite_app" }.first
      if content
        @content = JSON.parse(content.value)
      else
        @content = {}
      end
    end

    def [](key)
      @content[key]
    end

    def []=(key, val)
      @content[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      name = "_rails_lite_app"
      content = @content.to_json
      cookie = WEBrick::Cookie.new(name, content)
      res.cookies << cookie
    end
  end
end
