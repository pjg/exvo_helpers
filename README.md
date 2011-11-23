# Exvo Helpers

Ruby gem providing helper methods for various Exvo apps/services. It takes into account the Rails.env (or Merb.env). Also allows overwriting of the defaults by ENV variables (and directly too, see below).

## Helpers

Results are from the 'development' Rails environment:

```ruby
Exvo::Helpers.cdn_host      => 'www.exvo.local'
Exvo::Helpers.cfs_host      => 'cfs.exvo.local'
Exvo::Helpers.desktop_host  => 'www.exvo.local'
Exvo::Helpers.themes_host   => 'themes.exvo.local'
Exvo::Helpers.blog_host     => 'blog.exvo.local'
Exvo::Helpers.contacts_host => 'contacts.exvo.local'
Exvo::Helpers.inbox_host    => 'inbox.exvo.local'
Exvo::Helpers.music_host    => 'music.exvo.local'
Exvo::Helpers.pics_host     => 'pics.exvo.local'

Exvo::Helpers.cdn_uri      => 'http://www.exvo.local'
Exvo::Helpers.cfs_uri      => 'http://cfs.exvo.local'
Exvo::Helpers.desktop_uri  => 'http://www.exvo.local'
Exvo::Helpers.themes_uri   => 'http://themes.exvo.local'
Exvo::Helpers.blog_uri     => 'http://blog.exvo.local'
Exvo::Helpers.contacts_uri => 'http://contacts.exvo.local'
Exvo::Helpers.inbox_uri    => 'http://inbox.exvo.local'
Exvo::Helpers.music_uri    => 'http://music.exvo.local'
Exvo::Helpers.pics_uri     => 'http://pics.exvo.local'
```

For consistency, there are also read-only `auth_host/auth_uri` methods, that just pass execution to the [exvo-auth](https://github.com/Exvo/Auth) gem (so it's required that exvo-auth gem is available when using them):

```ruby
Exvo::Helpers.auth_host => 'exvo.auth.local'
Exvo::Helpers.auth_uri  => 'http://exvo.auth.local'
```


### Overwriting

There are two ways to do it. One is by the means of ENV variables (preferred one):

```ruby
ENV['CDN_HOST']      = 'test.cdn.exvo.com'
ENV['CFS_HOST']      = 'test.cfs.exvo.com'
ENV['DESKTOP_HOST']  = 'test.exvo.com'
ENV['THEMES_HOST']   = 'test.themes.exvo.com'
ENV['BLOG_HOST']     = 'test.blog.exvo.local'
ENV['CONTACTS_HOST'] = 'test.contacts.exvo.local'
ENV['INBOX_HOST']    = 'test.inbox.exvo.local'
ENV['MUSIC_HOST']    = 'test.music.exvo.local'
ENV['PICS_HOST']     = 'test.pics.exvo.local'
```

The other one is to set it in the application's config file:

```ruby
Exvo::Helpers.cdn_host      = 'test.cfs.exvo.com'
Exvo::Helpers.cfs_host      = 'test.cfs.exvo.com'
Exvo::Helpers.desktop_host  = 'test.exvo.com'
Exvo::Helpers.themes_host   = 'test.themes.exvo.com'
Exvo::Helpers.blog_host     = 'test.blog.exvo.local'
Exvo::Helpers.contacts_host = 'test.contacts.exvo.local'
Exvo::Helpers.inbox_host    = 'test.inbox.exvo.local'
Exvo::Helpers.music_host    = 'test.music.exvo.local'
Exvo::Helpers.pics_host     = 'test.pics.exvo.local'
```


## View helpers

There is a `javascript_bundle_include_tag` view helper function, which includes a different Desktop JS bundles depending on current environment.

The following declaraions:

```ruby
= javascript_bundle_include_tag("plugins")
= javascript_bundle_include_tag("utils")
= javascript_bundle_include_tag("widgets")
= javascript_bundle_include_tag("dock")
= javascript_bundle_include_tag("uploader")
```

will output this for the 'development' environment:

```html
<script src="http://www.exvo.local/javascripts/bundles/plugins.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/utils.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/widgets.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/dock.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/uploader.js" type="text/javascript"></script>
```


Copyright © 2011 Exvo.com Development BV
