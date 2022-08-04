# frozen_string_literal: true

module Validators
  class PageViewValidator
    require 'pry'
    URL_REGEX = %r{^/\S*}
    IP_REGEX = /(\d{3}\.){3}\d{3}/

    def valid?(page_view)
      url_valid?(page_view.url) && ip_valid?(page_view.ip)
    end

    private

    def url_valid?(url)
      url.match?(URL_REGEX)
    end

    def ip_valid?(ip)
      ip.match?(IP_REGEX)
    end
  end
end
