# Copyright (c) Microsoft Corporation
# All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 
#
# THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR 
# CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING 
# WITHOUT LIMITATION ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE,
# FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABLITY OR NON-INFRINGEMENT. 

# See the Apache Version 2.0 License for specific language governing
# permissions and limitations under the License.

require 'restclient'
require 'multi_json'
require 'addressable/uri'

module Yammer
class HttpAdapter

  def self.log=(output)
    RestClient.log = output
  end

  attr_reader :site_url, :connection_options

  def initialize(site_url, opts={})
    unless site_url =~ /^https?/
      raise ArgumentError, "site_url must include either http or https scheme"
    end
    @site_url = site_url
    @connection_options = opts
  end

  # set the url to be used for creating an http connection
  # @param url [string]
  def site_url=(url)
    @site_url = url
    @host     = nil
    @scheme   = nil
  end

  def host
    @host ||= parsed_url.host
  end

  def scheme
    @scheme ||= parsed_url.scheme
  end

  def absolute_url(path='')
    "#{@site_url}#{path}"
  end

  def connection_options=(opts)
    raise ArgumentError, 'expected Hash' unless opts.is_a?(Hash)
    @connection_options = opts
  end

  def send_request(method, path, opts={})
    begin
      params  = opts.fetch(:params, {})

      req_opts = self.connection_options.merge({
        :method  => method,
        :headers => opts.fetch(:headers, {})
      })

      case method
      when :get, :delete
        query = Addressable::URI.form_encode(params)
        normalized_path = query.empty? ? path : [path, query].join("?")
        req_opts[:url]  = absolute_url(normalized_path)
      when :post, :put
        req_opts[:payload] = params
        req_opts[:url]     = absolute_url(path)
      else
        raise "Unsupported HTTP method, #{method}"
      end

      resp = RestClient::Request.execute(req_opts)
    
      result = Yammer::ApiResponse.new(resp.headers, resp.body, resp.code)
    rescue => e
      if e.is_a?(RestClient::ExceptionWithResponse)
        Yammer::Error.from_status(e.http_code)
      else
        raise e
      end
    end
  end

private
  def parsed_url
    Addressable::URI.parse(@site_url)
  end

end
end