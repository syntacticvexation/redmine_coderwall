# A helperized version of
# Simple and Stupid Ruby API for Coderwall.com
# Vivien Didelot <vivien@didelot.org>
# https://gist.github.com/1007591

require_dependency 'my_helper'

require "open-uri"
require "json"

module CoderwallHelperPatch
  def self.included(base) # :nodoc:
#     base.send(:include, InstanceMethods)
  end
  
  class Achievement
    attr_reader :name, :badge, :description

    def initialize(hashed_badge)
      @name, @badge, @description = hashed_badge.values
    end
  end

  module_function

  def achievements_of(username)
    raise(ArgumentError, "Invalid username") if username.empty?
    url = URI.escape("http://coderwall.com/#{username}.json")
    begin
      response = JSON.load(open(url))
    rescue OpenURI::HTTPError
      raise(ArgumentError, "Invalid username")
    end

    response["badges"].map { |badge| Achievement.new(badge) }
  end
end

# now we should include this module in ApplicationHelper module
unless ApplicationHelper.included_modules.include? CoderwallHelperPatch
    ApplicationHelper.send(:include, CoderwallHelperPatch)
end