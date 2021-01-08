# frozen_string_literal: true

require "user_agent"

class PlatformAgent
  Browser = Struct.new(:browser, :version)

  def initialize(user_agent_string)
    self.user_agent_string = user_agent_string
  end

  delegate :browser, :version, :product, :os, to: :user_agent

  def desktop?
    !mobile?
  end

  def mobile?
    iphone? || android? || other_phones? || ENV["platform"] == "mobile"
  end

  def iphone?
    match?(/iPhone/)
  end

  def android?
    match?(/Android/)
  end

  def other_phones?
    match?(/(iPod|Windows Phone|BlackBerry|BB10.*Mobile|Mobile.*Firefox|mobile)/)
  end

  def headless?
    match?(/HeadlessChrome/) || match?(/headless/i)
  end

  def bot?
    match?(/\(.*https?:\/\/.*\)/) || match?(/googlebot/i)
  end

  def support
    case
    when compatibility_browser?
      :compatible
    when unsupported_browser?
      :unsupported
    else
      :supported
    end
  end

  def missing?
    user_agent_string.nil?
  end

  def to_s
    case
    when desktop? then
      "desktop"
    else
      "mobile"
    end
  end

  def to_i
    case
    when desktop? then
      :desktop
    when iphone? then
      :iphone
    when android? then
      :android
    when mobile? then
      :mobile
    else
      :unknown
    end
  end

  def to_sym
    to_s.to_sym
  end

  # Samsung Internet is considered a compatibility browser due to amount of bugs it contains (file uploads and web share are two)
  # Desktop browsers are usually considered compatibility browser due to limited support to the webshare api and service workers
  def compatibility_browser?(include_desktop: true)
    @compatibility ||= supported_browsers.detect { |browser| user_agent <= browser } || match?(/SamsungBrowser/) || (desktop? && include_desktop)
  end

  def unsupported_browser?
    @unsupported ||= unsupported_browsers.detect { |browser| user_agent == browser }
  end

  private
    attr_accessor :user_agent_string

    def match?(pattern)
      user_agent_string.to_s.match?(pattern)
    end

    def user_agent
      @user_agent ||= UserAgent.parse(user_agent_string)
    end

    def supported_browsers
      [Browser.new("Safari", "12.1"),
       Browser.new("Chrome", "58"),
       Browser.new("Firefox", "55"),
       Browser.new("Opera", "45"),
       Browser.new("Edge", "78")]
    end

    def unsupported_browsers
      ["Internet Explorer", "Opera Mobi"]
    end
end
