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

module Yammer
  module Error

    class << self
      def from_status(status=nil)
        case status
        when 400
          BadRequest
        when 401
          Unauthorized
        when 403
          Forbidden
        when 404
          NotFound
        when 406
          NotAcceptable
        when 429
          RateLimitExceeded
        when 500
          InternalServerError
        when 502
          BadGateway
        when 503
          ServiceUnavailable
        else
          ApiError
        end
      end
    end

    # Raised when Yammer returns unknown HTTP status code
    class ApiError < StandardError;  end

    # Raised when Yammer returns the HTTP status code 400
    class BadRequest < ApiError; end

    # Raised when Yammer returns the HTTP status code 401
    class Unauthorized < ApiError; end

    # Raised when Yammer returns the HTTP status code 403
    class Forbidden < ApiError; end

    # Raised when Yammer returns the HTTP status code 404
    class NotFound < ApiError; end

    # Raised when Yammer returns the HTTP status code 406
    class NotAcceptable < ApiError; end

    # Raised when Yammer returns the HTTP status code 429
    class RateLimitExceeded < ApiError; end

    # Raised when Yammer returns the HTTP status code 500
    class InternalServerError < ApiError; end

    # Raised when Yammer returns the HTTP status code 502
    class BadGateway < ApiError; end

    # Raised when Yammer returns the HTTP status code 503
    class ServiceUnavailable < ApiError; end
  end
end