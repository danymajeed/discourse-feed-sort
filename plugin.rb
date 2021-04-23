# frozen_string_literal: true

# name: feed-sort
# about: Sort user feed by assigning score to topics
# version: 1.0
# authors: danymajeed
# url: https://github.com/danymajeed/discourse-feed-sort

enabled_site_setting :feed_sort

PLUGIN_NAME ||= 'FeedSort'

after_initialize do
  # https://github.com/discourse/discourse/blob/master/lib/plugin/instance.rb
end
