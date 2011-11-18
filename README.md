# Exvo Helpers

Ruby gem providing helper methods for various Exvo apps/services. It takes into account the Rails.env (or Merb.env). Also allows overwriting of the defaults by ENV variables (and directly too, see below).

## Examples

Results are from the 'development' Rails environment:

```ruby
Exvo::Helpers.cdn_host     => 'www.exvo.local'
Exvo::Helpers.cfs_host     => 'cfs.exvo.local'
Exvo::Helpers.desktop_host => 'www.exvo.local'
Exvo::Helpers.themes_host  => 'themes.exvo.local'

Exvo::Helpers.cdn_uri      => 'http://www.exvo.local'
Exvo::Helpers.cfs_uri      => 'http://cfs.exvo.local'
Exvo::Helpers.desktop_uri  => 'http://www.exvo.local'
Exvo::Helpers.themes_uri   => 'http://themes.exvo.local'
```

For consistency, there are also read-only `auth_host/auth_uri` methods, that just pass execution to the [exvo-auth](https://github.com/Exvo/Auth) gem (so it's required that exvo-auth gem is available when using them):

```ruby
Exvo::Helpers.auth_host => 'exvo.auth.local'
Exvo::Helpers.auth_uri  => 'http://exvo.auth.local'
```


## Overwriting

There are two ways to do it. One is by the means of ENV variables (preferred one):

```ruby
ENV['CDN_HOST']     = 'test.cdn.exvo.com'
ENV['CFS_HOST']     = 'test.cfs.exvo.com'
ENV['DESKTOP_HOST'] = 'test.exvo.com'
ENV['THEMES_HOST']  = 'test.themes.exvo.com'
```

The other one is to set it in the application's config file:

```ruby
Exvo::Helpers.cdn_host     = 'test.cfs.exvo.com'
Exvo::Helpers.cfs_host     = 'test.cfs.exvo.com'
Exvo::Helpers.desktop_host = 'test.exvo.com'
Exvo::Helpers.themes_host  = 'test.themes.exvo.com'
```



Copyright © 2011 Exvo.com Development BV
