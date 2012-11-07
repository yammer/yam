module Yam
  # Defines HTTP verbs
  module Request
    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    def post(path, params={}, options={})
      request(:post, path, params, options)
    end

    def request(method, path, params, options)
      conn = connection(options)
      path = (conn.path_prefix + path).gsub(/\/\//,'/') if conn.path_prefix != '/'

      response = conn.send(method,path,params)
      response.body
    end
  end
end
