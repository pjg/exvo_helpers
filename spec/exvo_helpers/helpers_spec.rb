require 'spec_helper'

describe Exvo::Helpers do

  describe ".env class method" do
    it "returns 'production' when Rails.env is set to 'production'" do
      Kernel.const_set(:Rails, Module)
      Rails.should_receive(:env).and_return('production')
      Exvo::Helpers.env.should eql('production')
    end

    it "allows setting env" do
      Exvo::Helpers.env = 'test'
      Exvo::Helpers.env.should eql('test')
      Exvo::Helpers.env = nil
    end
  end

  describe "uri methods in production environment" do
    before do
      Exvo::Helpers.stub(:env).and_return('production')
    end

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
    before do
      Exvo::Helpers.stub(:env).and_return('production')
    end

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

  describe "ENV setting overrides the defaults" do
    # as all methods are defined the same using metaprogramming, only testing for 1 is enough
    let(:cdn_host) { "test.cdn.exvo.com" }

    before do
      # clear any previous memoization
      Exvo::Helpers.cdn_host = nil

      # set ENV
      ENV["CDN_HOST"] = cdn_host
    end

    specify { Exvo::Helpers.cdn_host.should eql(cdn_host) }

    after do
      ENV["CDN_HOST"] = nil
    end
  end

  describe "setting host directly overrides the defaults" do
    # as all methods are defined the same using metaprogramming, only testing for 1 is enough
    let(:cdn_host) { "new.cdn.exvo.com" }

    before do
      Exvo::Helpers.cdn_host = cdn_host
    end

    specify { Exvo::Helpers.cdn_host.should eql(cdn_host) }

    after do
      Exvo::Helpers.cdn_host = nil
    end
  end

  describe "auth_host/auth_uri methods which pass to the ExvoAuth gem" do
    let(:host) { 'new.auth.exvo.com' }
    let(:uri) { "http://#{host}"}

    it "raises an error when ExvoAuth is not available" do
      expect { Exvo::Helpers.auth_uri }.to raise_error
      expect { Exvo::Helpers.auth_host }.to raise_error
    end

    it "passes to the ExvoAuth when it is available" do
      Kernel.const_set(:ExvoAuth, Module)
      ExvoAuth.const_set(:Config, Module)

      ExvoAuth::Config.should_receive(:host).and_return(host)
      Exvo::Helpers.auth_host.should eql(host)

      ExvoAuth::Config.should_receive(:uri).and_return(uri)
      Exvo::Helpers.auth_uri.should eql(uri)
    end
  end

end
