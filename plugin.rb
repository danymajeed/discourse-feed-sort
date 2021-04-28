# frozen_string_literal: true

# name: feed-sort
# about: Sort user feed by assigning score to topics
# version: 1.0
# authors: danymajeed
# url: https://github.com/danymajeed/discourse-feed-sort

enabled_site_setting :feed_sort

PLUGIN_NAME ||= 'FeedSort'

after_initialize do
  class ::PostCreator
        module UpdateTopicBump
            def update_topic_stats
                attrs = { updated_at: Time.now }
                if @post.post_type != Post.types[:whisper] && !@opts[:silent]
                    attrs[:last_posted_at] = @post.created_at
                    attrs[:last_post_user_id] = @post.user_id
                    attrs[:word_count] = (@topic.word_count || 0) + @post.word_count
                    attrs[:excerpt] = @post.excerpt_for_topic if new_topic?
                    if @topic.created_at.to_time > Time.now - (3600 * SiteSetting.disable_bump_for)
                      attrs[:bumped_at] = @post.created_at
                    end
                end
                @topic.update_columns(attrs)
            end
        end
        prepend UpdateTopicBump
    end

    class ::PostRevisor
        module UpdateTopicBump
            def bypass_bump?
                return true
            end
        end
        prepend UpdateTopicBump
    end

    # class ::PostAction
    #     module UpdateTopicBump
    #         def update_counters
    #             super()
    #             # bumping topic on post like
    #             bumped_at = Time.now()
    #             topic_id = Post.with_deleted.where(id: post_id).pluck_first(:topic_id)
    #             post = Post.where(id: post_id)
    #             Topic.where(id: topic_id).update_all(
    #                 bumped_at: bumped_at
    #             )
    #         end
    #     end
    #     prepend UpdateTopicBump
    # end
end
