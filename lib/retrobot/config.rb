require 'active_support'
require 'active_support/core_ext'
require 'psych'
require 'erb'

class Retrobot
  class Config
    KEYS = %i(
      tweets_csv
      consumer_key
      consumer_secret
      access_token
      access_secret
      retro_days
      retweet
      debug
      dryrun
      loop_interval
      retry_interval
      retry_count
      add_in_reply_to_url
      suppress_pattern
      remove_hashtag
    )

    DEFAULTS = {
      tweets_csv: './tweets/tweets.csv',
      retro_days: 365,
      retweet: false,
      debug: false,
      dryrun: false,
      loop_interval: 3,
      retry_interval: 3,
      retry_count: 5,
      add_in_reply_to_url: false,
      suppress_pattern: nil,
      remove_hashtag: false,
    }

    def initialize(options={})
      @options = DEFAULTS.merge(options.symbolize_keys)
    end

    def merge!(hash)
      @options.merge!(hash)
    end

    KEYS.each do |k|
      define_method(k) { @options[k] }
    end

    def retro_days
      @options[:retro_days].to_i.days
    end

    def tweets_csv
      Pathname.new(@options[:tweets_csv])
    end

    def loop_interval;  @options[:loop_interval].to_i; end
    def retry_interval; @options[:retry_interval].to_i; end
    def retry_count;    @options[:retry_count].to_i; end

    def load_yaml_file!(path)
      yaml = ERB.new(File.read(path.to_s)).result
      @options.merge! Psych.load(yaml).symbolize_keys
    end
  end
end
