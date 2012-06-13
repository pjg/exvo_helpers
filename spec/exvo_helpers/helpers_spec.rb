require 'spec_helper'

describe Exvo::Helpers do

  describe ".env class method" do
    it "should fall back to 'production' if Rails & Merb are undefined" do
      Exvo::Helpers.env.should eql('production')
    end

    it "returns 'staging' when Rails.env is set to 'staging'" do
      Kernel.const_set(:Rails, Module)
      Rails.should_receive(:env).and_return('staging')
      Exvo::Helpers.env.should eql('staging')
      Kernel.send(:remove_const, :Rails)
    end

    it "returns 'staging' when RACK_ENV is set to 'staging'" do
      ENV["RACK_ENV"] = 'staging'
      Exvo::Helpers.env.should eql('staging')
      ENV.delete("RACK_ENV")
    end

    it "allows setting env" do
      Exvo::Helpers.env = 'test'
      Exvo::Helpers.env.should eql('test')
    end

    after do
      Exvo::Helpers.env = nil
    end
  end

  describe "uri methods in production environment" do
    specify { Exvo::Helpers.auth_uri.should match('auth.exvo.com') }
    specify { Exvo::Helpers.cdn_uri.should match('d33gjlr95u9pgf.cloudfront.net') }
    specify { Exvo::Helpers.cfs_uri.should match('cfs.exvo.com') }
    specify { Exvo::Helpers.desktop_uri.should match('www.exvo.com') }
    specify { Exvo::Helpers.themes_uri.should match('themes.exvo.com') }
    specify { Exvo::Helpers.blog_uri.should match('blog.exvo.com') }
    specify { Exvo::Helpers.contacts_uri.should match('contacts.exvo.com') }
    specify { Exvo::Helpers.inbox_uri.should match('inbox.exvo.com') }
    specify { Exvo::Helpers.music_uri.should match('music.exvo.com') }
    specify { Exvo::Helpers.pics_uri.should match('pics.exvo.com') }
    specify { Exvo::Helpers.preview_uri.should match('preview.exvo.com') }
  end

  describe "host methods in production environment" do
    specify { Exvo::Helpers.auth_host.should match('auth.exvo.com') }
    specify { Exvo::Helpers.cdn_host.should eql('d33gjlr95u9pgf.cloudfront.net') }
    specify { Exvo::Helpers.cfs_host.should eql('cfs.exvo.com') }
    specify { Exvo::Helpers.desktop_host.should eql('www.exvo.com') }
    specify { Exvo::Helpers.themes_host.should eql('themes.exvo.com') }
    specify { Exvo::Helpers.blog_host.should eql('blog.exvo.com') }
    specify { Exvo::Helpers.contacts_host.should eql('contacts.exvo.com') }
    specify { Exvo::Helpers.inbox_host.should eql('inbox.exvo.com') }
    specify { Exvo::Helpers.music_host.should eql('music.exvo.com') }
    specify { Exvo::Helpers.pics_host.should eql('pics.exvo.com') }
    specify { Exvo::Helpers.preview_host.should eql('preview.exvo.com') }
  end

  describe "#auth_debug by default for production env" do
    specify { Exvo::Helpers.auth_debug.should be_false }

    after do
      # reset cached class instance variable
      Exvo::Helpers.auth_debug = nil
    end
  end

  describe "#auth_require_ssl by default for production env" do
    specify { Exvo::Helpers.auth_require_ssl.should be_true }

    after do
      # reset cached class instance variable
      Exvo::Helpers.auth_require_ssl = nil
    end
  end

  describe "#sso_cookie_domain by default for production env" do
    specify { Exvo::Helpers.sso_cookie_domain.should eq("exvo.com") }

    after do
      # reset cached class instance variable
      Exvo::Helpers.sso_cookie_domain = nil
    end
  end

  describe "ENV settings override the defaults" do
    # all *host* methods are defined the same using metaprogramming, only testing for 1 is enough
    let(:cdn_host) { "test.cdn.exvo.com" }
    let(:sso_cookie_domain) { "exvo.dev" }
    let(:auth_client_id) { '123' }
    let(:auth_client_secret) { 'abc' }
    let(:auth_require_ssl) { 'false' }

    before do
      # clear any previous memoization
      Exvo::Helpers.cdn_host = nil
      Exvo::Helpers.sso_cookie_domain = nil
      Exvo::Helpers.auth_client_id = nil
      Exvo::Helpers.auth_client_secret = nil
      Exvo::Helpers.auth_require_ssl = nil

      # set ENV
      ENV["CDN_HOST"] = cdn_host
      ENV["SSO_COOKIE_DOMAIN"] = sso_cookie_domain
      ENV["AUTH_CLIENT_ID"] = auth_client_id
      ENV["AUTH_CLIENT_SECRET"] = auth_client_secret
      ENV["AUTH_REQUIRE_SSL"] = auth_require_ssl
    end

    specify { Exvo::Helpers.cdn_host.should eql(cdn_host) }
    specify { Exvo::Helpers.sso_cookie_domain.should eql(sso_cookie_domain) }
    specify { Exvo::Helpers.auth_client_id.should eq(auth_client_id) }
    specify { Exvo::Helpers.auth_client_secret.should eq(auth_client_secret) }
    specify { Exvo::Helpers.auth_uri.should match(/http:\/\//) }

    after do
      ENV["CDN_HOST"] = nil
      ENV["SSO_COOKIE_DOMAIN"] = nil
      ENV["AUTH_CLIENT_ID"] = nil
      ENV["AUTH_CLIENT_SECRET"] = nil
      ENV["AUTH_REQUIRE_SSL"] = nil
    end
  end

  describe "direct settings override the defaults" do
    # all *host* methods are defined the same using metaprogramming, only testing for 1 is enough
    let(:cdn_host) { "new.cdn.exvo.com" }
    let(:sso_cookie_domain) { "exvo.new" }
    let(:auth_require_ssl) { false }

    before do
      Exvo::Helpers.cdn_host = cdn_host
      Exvo::Helpers.sso_cookie_domain = sso_cookie_domain
      Exvo::Helpers.auth_require_ssl = auth_require_ssl
    end

    specify { Exvo::Helpers.cdn_host.should eql(cdn_host) }
    specify { Exvo::Helpers.sso_cookie_domain.should eql(sso_cookie_domain) }
    specify { Exvo::Helpers.auth_uri.should match(/http:\/\//) }

    after do
      Exvo::Helpers.cdn_host = nil
      Exvo::Helpers.sso_cookie_domain = nil
      Exvo::Helpers.auth_require_ssl = nil
    end
  end

end
