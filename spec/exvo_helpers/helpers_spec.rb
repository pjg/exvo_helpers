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

  describe "host methods in production environment" do
    before do
      Exvo::Helpers.stub(:env).and_return('production')
    end

    specify { Exvo::Helpers.cdn_host.should eql('cdn.exvo.com') }
    specify { Exvo::Helpers.cfs_host.should eql('cfs.exvo.com') }
    specify { Exvo::Helpers.desktop_host.should eql('www.exvo.com') }
    specify { Exvo::Helpers.themes_host.should eql('themes.exvo.com') }
  end

  describe "ENV setting overrides the defaults" do
    let(:cdn_host) { "test.cdn.exvo.com" }
    let(:cfs_host) { "test.cfs.exvo.com" }
    let(:desktop_host) { "test.exvo.com" }
    let(:themes_host) { "test.themes.exvo.com" }

    before do
      # clear any previous memoization
      Exvo::Helpers.cdn_host = nil
      Exvo::Helpers.cfs_host = nil
      Exvo::Helpers.desktop_host = nil
      Exvo::Helpers.themes_host = nil

      # set ENV
      ENV["CDN_HOST"] = cdn_host
      ENV["CFS_HOST"] = cfs_host
      ENV["DESKTOP_HOST"] = desktop_host
      ENV["THEMES_HOST"] = themes_host
    end

    specify { Exvo::Helpers.cdn_host.should eql(cdn_host) }
    specify { Exvo::Helpers.cfs_host.should eql(cfs_host) }
    specify { Exvo::Helpers.desktop_host.should eql(desktop_host) }
    specify { Exvo::Helpers.themes_host.should eql(themes_host) }
  end

  describe "setting host directly overrides the defaults" do
    let(:cdn_host) { "new.cdn.exvo.com" }
    let(:cfs_host) { "new.cfs.exvo.com" }
    let(:desktop_host) { "new.exvo.com" }
    let(:themes_host) { "new.themes.exvo.com" }

    before do
      Exvo::Helpers.cdn_host = cdn_host
      Exvo::Helpers.cfs_host = cfs_host
      Exvo::Helpers.desktop_host = desktop_host
      Exvo::Helpers.themes_host = themes_host
    end

    specify { Exvo::Helpers.cdn_host.should eql(cdn_host) }
    specify { Exvo::Helpers.cfs_host.should eql(cfs_host) }
    specify { Exvo::Helpers.desktop_host.should eql(desktop_host) }
    specify { Exvo::Helpers.themes_host.should eql(themes_host) }
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
