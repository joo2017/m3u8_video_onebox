# name: m3u8_video_onebox
# about: A plugin to support m3u8 video files using Video.js
# version: 0.1
# authors: Your Name
# url: https://github.com/yourusername/m3u8_video_onebox

enabled_site_setting :m3u8_video_onebox_enabled

register_asset "javascripts/discourse/lib/video_onebox.js", :server_side

after_initialize do
  module ::Onebox
    module Engine
      class M3u8VideoOnebox
        include Engine

        matches_regexp(%r{^(https?:)?//.*\.(mov|mp4|webm|ogv|m3u8)(\?.*)?$}i)

        def always_https?
          AllowlistedGenericOnebox.host_matches(uri, AllowlistedGenericOnebox.https_hosts)
        end

        def to_html
          if @url.match(%r{\.m3u8$})
            randomId = Time.now.to_i.to_s + rand(100000000).to_s
            video_tag_html = <<-HTML
            <div class="onebox video-onebox videoWrap">
              <video id='#{randomId}' class="video-js vjs-default-skin vjs-16-9" controls preload="auto" width="100%" data-setup='{"fluid": true}'>
                <source src="#{@url}" type="application/x-mpegURL">
              </video>
            </div>
            HTML
          else
            escaped_url = ::Onebox::Helpers.normalize_url_for_output(@url)
            video_tag_html = <<-HTML
              <div class="onebox video-onebox">
                <video width='100%' height='100%' controls>
                  <source src='#{escaped_url}'>
                  <a href='#{escaped_url}'>#{@url}</a>
                </video>
              </div>
            HTML
          end
          video_tag_html
        end

        def placeholder_html
          SiteSetting.enable_diffhtml_preview ? to_html : ::Onebox::Helpers.video_placeholder_html
        end
      end
    end
  end

  Onebox::Engine::M3u8VideoOnebox
end
