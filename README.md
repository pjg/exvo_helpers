# Exvo Helpers

Ruby gem providing helper methods for various Exvo apps/services. It takes into account the Rails.env (or Merb.env). Also allows overwriting the defaults by ENV variables (and directly too, see below).

This gem is used by both [omniauth-exvo](https://github.com/Exvo/omniauth-exvo/) and [exvo-auth](https://github.com/Exvo/Auth) gems as the authoritative source of **all auth related configuration**.


## Helpers

Results are from the 'development' Rails environment:

```ruby
Exvo::Helpers.auth_debug       => false
Exvo::Helpers.auth_require_ssl => false

Exvo::Helpers.auth_client_id     => nil
Exvo::Helpers.auth_client_secret => nil

Exvo::Helpers.sso_cookie_domain => 'exvo.local'
Exvo::Helpers.sso_cookie_secret => 'some secret cookie signing key'

Exvo::Helpers.auth_host     => 'auth.exvo.local'
Exvo::Helpers.cdn_host      => 'www.exvo.local'
Exvo::Helpers.cfs_host      => 'cfs.exvo.local'
Exvo::Helpers.desktop_host  => 'home.exvo.local'
Exvo::Helpers.themes_host   => 'themes.exvo.local'
Exvo::Helpers.blog_host     => 'www.exvo.local'
Exvo::Helpers.contacts_host => 'contacts.exvo.local'
Exvo::Helpers.inbox_host    => 'inbox.exvo.local'
Exvo::Helpers.music_host    => 'music.exvo.local'
Exvo::Helpers.pics_host     => 'pics.exvo.local'
Exvo::Helpers.preview_host  => 'preview.exvo.local'
Exvo::Helpers.store_host    => 'store.exvo.local'

Exvo::Helpers.auth_uri     => 'http://auth.exvo.local'
Exvo::Helpers.cdn_uri      => 'http://www.exvo.local'
Exvo::Helpers.cfs_uri      => 'http://cfs.exvo.local'
Exvo::Helpers.desktop_uri  => 'http://home.exvo.local'
Exvo::Helpers.themes_uri   => 'http://themes.exvo.local'
Exvo::Helpers.blog_uri     => 'http://www.exvo.local/blog'
Exvo::Helpers.contacts_uri => 'http://contacts.exvo.local'
Exvo::Helpers.inbox_uri    => 'http://inbox.exvo.local'
Exvo::Helpers.music_uri    => 'http://music.exvo.local'
Exvo::Helpers.pics_uri     => 'http://pics.exvo.local'
Exvo::Helpers.preview_uri  => 'http://preview.exvo.local'
Exvo::Helpers.store_uri    => 'http://store.exvo.local'
```


### Overwriting the defaults

There are two ways to do it. One is by the means of ENV variables (the preferred method):

```ruby
ENV['AUTH_DEBUG']       = 'true'
ENV['AUTH_REQUIRE_SSL'] = 'true'

ENV['AUTH_CLIENT_ID']     = '123'
ENV['AUTH_CLIENT_SECRET'] = 'abc'

ENV['SSO_COOKIE_DOMAIN'] = 'exvo.dev'
ENV['SSO_COOKIE_SECRET'] = 'exvo.dev'

ENV['AUTH_HOST']     = 'test.auth.exvo.com'
ENV['CDN_HOST']      = 'test.cdn.exvo.com'
ENV['CFS_HOST']      = 'test.cfs.exvo.com'
ENV['DESKTOP_HOST']  = 'test.exvo.com'
ENV['THEMES_HOST']   = 'test.themes.exvo.com'
ENV['BLOG_HOST']     = 'test.www.exvo.local'
ENV['CONTACTS_HOST'] = 'test.contacts.exvo.local'
ENV['INBOX_HOST']    = 'test.inbox.exvo.local'
ENV['MUSIC_HOST']    = 'test.music.exvo.local'
ENV['PICS_HOST']     = 'test.pics.exvo.local'
ENV['PREVIEW_HOST']  = 'test.preview.exvo.local'
ENV['STORE_HOST']    = 'test.store.exvo.local'
```

The other one is to set it in the application's config file:

```ruby
Exvo::Helpers.auth_debug       = true
Exvo::Helpers.auth_require_ssl = true

Exvo::Helpers.auth_client_id     = '123'
Exvo::Helpers.auth_client_secret = 'abc'

Exvo::Helpers.sso_cookie_domain = 'exvo.dev'
Exvo::Helpers.sso_cookie_key = 'some secret key'

Exvo::Helpers.auth_host     = 'test.auth.exvo.com'
Exvo::Helpers.cdn_host      = 'test.cdn.exvo.com'
Exvo::Helpers.cfs_host      = 'test.cfs.exvo.com'
Exvo::Helpers.desktop_host  = 'test.exvo.com'
Exvo::Helpers.themes_host   = 'test.themes.exvo.com'
Exvo::Helpers.blog_host     = 'test.www.exvo.local'
Exvo::Helpers.contacts_host = 'test.contacts.exvo.local'
Exvo::Helpers.inbox_host    = 'test.inbox.exvo.local'
Exvo::Helpers.music_host    = 'test.music.exvo.local'
Exvo::Helpers.pics_host     = 'test.pics.exvo.local'
Exvo::Helpers.preview_host  = 'test.preview.exvo.local'
Exvo::Helpers.store_host    = 'test.store.exvo.local'
```


## View helpers

There are also all kinds of view helpers available, which output html tags based on `env`.

All examples are for the 'development' environment.


### javascript_bundle_include_tag

```ruby
= javascript_bundle_include_tag("plugins")
= javascript_bundle_include_tag("utils")
= javascript_bundle_include_tag("widgets")
= javascript_bundle_include_tag("dock")
= javascript_bundle_include_tag("uploader")
```

=>

```html
<script src="http://www.exvo.local/javascripts/bundles/plugins.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/utils.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/widgets.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/dock.js" type="text/javascript"></script>
<script src="http://www.exvo.local/javascripts/bundles/uploader.js" type="text/javascript"></script>
```


### themes_stylesheet_link_tag

Note, that this helper does not support full API of Rails' `stylesheet_link_tag` (works best with only one CSS path as argument).

```ruby
= themes_stylesheet_link_tag "frost/all", :media => 'all'
```

=>

```html
<link href="http://themes.exvo.local/stylesheets/themes/frost/all.css" media="all" rel="stylesheet" type="text/css" />
```


### themes_image_tag

```ruby
= themes_image_tag("icons/exvo.png", :alt => 'Exvo')
```

=>

```html
<img alt="Exvo" src="http://themes.exvo.local/stylesheets/images/icons/exvo.png" />
```


### google_analytics(account, opts = {})

Asynchronous Google Analytics javascript snippet to track page views. Note, that it will output the javascript analytics snippet only in production environment.

```ruby
= google_analytics('UA-XXXXXXX-X', :domain => 'none', :track_hash_changes => true)
```

=>

```html
<script type="text/javascript">
  var _gaq = _gaq || [];
  ...
```


### kissmetrics

KISSmetrics javascript snippet to track users. Note, that you need to have `ENV["KISSMETRICS_KEY"]` key set.

```ruby
= kissmetrics
```

=>

```html
<script type="text/javascript">
  var _kmq = _kmq || [];
  function _kms(u) {
    setTimeout(function() {
    ...
```




Copyright © 2011-2012 Exvo.com Development BV, released under the MIT license
