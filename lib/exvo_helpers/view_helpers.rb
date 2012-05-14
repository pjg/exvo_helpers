module Exvo

  module ViewHelpers

    # Returns `javascript_include_tag` with link to js bundles (based on env)
    def javascript_bundle_include_tag(bundle)
      case Exvo::Helpers.env.to_sym
      when :production, :staging
        javascript_include_tag "#{Exvo::Helpers.cdn_uri}/javascripts/#{bundle}.js"
      else
        javascript_include_tag "#{Exvo::Helpers.cdn_uri}/javascripts/bundles/#{bundle}.js"
      end
    end

    # Returns `stylesheet_link_tag` with link to css on themes (based on env)
    def themes_stylesheet_link_tag(path, options = {})
      path = '/' + path unless path.start_with?('/')
      path = path + '.css' unless path.end_with?('.css')
      stylesheet_link_tag(Exvo::Helpers.themes_uri + '/stylesheets/themes' + path, options)
    end

    # Returns `image_tag` with link to image on themes (based on env)
    def themes_image_tag(path, options = {})
      path = '/' + path unless path.start_with?('/')
      image_tag(Exvo::Helpers.themes_uri + '/stylesheets/images' + path, options)
    end

    def google_analytics(account, opts = {})
      domain = opts.delete(:domain)
      track_hash_changes = opts.delete(:track_hash_changes)

      out = <<END
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '#{account}']);
END

      if domain
        out += <<END
  _gaq.push(['_setDomainName', '#{domain}']);
END
      end

      out += <<END
  _gaq.push(['_setAllowLinker', true]);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
END

      if track_hash_changes
        out += <<END

  var current_location_hash = window.location.hash;
  var update_hash = function() {
    if (current_location_hash != window.location.hash) {
      current_location_hash = window.location.hash;
      _gaq.push(['_trackPageview', current_location_hash]);
    }
  }
  setInterval(update_hash, 500);
END
      end

      out += <<END
</script>
END

      if Exvo::Helpers.env.to_sym == :production
        out.respond_to?(:html_safe) ? out.html_safe : out
      end
    end

    def kissmetrics
      out = <<END
<script type="text/javascript">
  var _kmq = _kmq || [];
  function _kms(u) {
    setTimeout(function() {
      var s = document.createElement('script');
      var f = document.getElementsByTagName('script')[0];
      s.type = 'text/javascript';
      s.async = true;
      s.src = u;
      f.parentNode.insertBefore(s, f);
    }, 1);
  }
  _kms('//i.kissmetrics.com/i.js');
  _kms('//doug1izaerwt3.cloudfront.net/#{ENV['KISSMETRICS_KEY']}.1.js');
END
      if current_user && current_user.email
        out += <<END
  _kmq.push(['identify', '#{current_user.email}']);
END
      end

      out += <<END
</script>
END

      out.respond_to?(:html_safe) ? out.html_safe : out
    end

  end

end
