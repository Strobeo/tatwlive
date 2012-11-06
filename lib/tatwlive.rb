module TATWlive

  def self.process_ig(data)
    Instagram.process_subscription(data) do |handler|
      handler.on_tag_changed do |media_id, d|
        get_tag_media(media_id)
      end
    end
  end


  def self.get_tag_media(tag)
    medias = Instagram.tag_recent_media(tag, min_tag_id: min_tag_id(tag), count: 20)
    set_min_tag_id(tag, medias['pagination']['min_tag_id'])
    ap medias['data'].length
  end

  def self.new_media(igm)
    media = Media.create(
      ig_id: igm.id, 
      user_id: igm.user.id, 
      user_name: igm.user.username, 
      user_pic: igm.user.profile_picture, 
      link: igm.link, 
      caption: igm.caption, 
      img_low: igm.images.low_resolution.url, 
      img_high: igm.images.standard_resolution.url, 
    )
    fire_push = Firebase.push("ig_media", media.attributes)
  end



# => Utility Methods 

  def self.min_tag_id(tag)
    Ohm.redis.get "TAG:#{tag}_min_id"
  end

  def self.set_min_tag_id(tag, id)
    Ohm.redis.set "TAG:#{tag}_min_id", id
  end

  class MediaPush
    include Sidekiq::Worker
    
    def perform(name, count)
      # do something
    end
  end

end