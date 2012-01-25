# CHANGELOG

Note, that only significant changes are listed.


## 0.2.0 (2012-01-20)

* **all** auth configuration is now at `Exvo::Helpers.auth_*` methods (`auth_client_id`, `auth_client_secret`, `auth_debug`, `auth_require_ssl`)


## 0.1.1 (2012-01-15)

* if Rails/Merb are undefined it will fall back to `'production'` for `@@env` (useful for specs in other gems depending on this)


## 0.1.0 (2012-01-13)

* `Exvo::Helpers.auth_host` and `Exvo::Helpers.auth_uri` are defined in here now (instead of falling back to the `exvo-auth` gem)


## 0.0.8 (2011-12-13)

* protocol agnostic URIs to cdn/cfs/themes (i.e. starting with '//')
* CDN host is now `*.cloudfront.net` for production/staging (so that it has proper SSL certificate)


## 0.0.7 (2011-12-08)

* host/uri helpers for preview app


## 0.0.6 (2011-11-24)

* Rails view helpers: `themes_image_tag` and `themes_stylesheet_link_tag`


## 0.0.5 (2011-11-23)

* Bugfix (temporarily force http for cdn bundles)


## 0.0.4 (2011-11-22)

* host/uri helpers for blog/contacts/inbox/music/pics


## 0.0.3 (2011-11-18)

* Rails view helpers: `javascript_bundle_include_tag`
* host/uri helpers for cdn


## 0.0.2 (2011-10-27)

* Refactoring


## 0.0.1 (2011-10-25)

* host/uri helpers for auth, which just pass to the `exvo-auth` gem
* host/uri helpers for cfs/desktop/themes