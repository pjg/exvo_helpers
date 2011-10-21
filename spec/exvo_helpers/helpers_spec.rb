require 'spec_helper'

describe Exvo do

  describe ".env class method" do
    it "returns 'production' when Rails.env is set to 'production'" do
      Kernel.const_set(:Rails, nil)
      Rails.should_receive(:env).and_return('production')
      Exvo.env.should eql('production')
    end
  end

  describe "host methods in production environment" do
    before do
      Exvo.should_receive(:env).and_return('production')
    end

    specify { Exvo.themes_host.should eql('themes.exvo.com') }
    specify { Exvo.cfs_host.should eql('cfs.exvo.com') }
    specify { Exvo.desktop_host.should eql('www.exvo.com') }
  end

  describe "ENV setting overrides the defaults" do
    let(:cfs_host) { "test.cfs.exvo.com" }
    let(:desktop_host) { "test.exvo.com" }
    let(:themes_host) { "test.themes.exvo.com" }

    before do
      # clear any previous memoization
      Exvo.cfs_host = nil
      Exvo.desktop_host = nil
      Exvo.themes_host = nil

      # set ENV
      ENV["CFS_HOST"] = cfs_host
      ENV["DESKTOP_HOST"] = desktop_host
      ENV["THEMES_HOST"] = themes_host
    end

    specify { Exvo.cfs_host.should eql(cfs_host) }
    specify { Exvo.desktop_host.should eql(desktop_host) }
    specify { Exvo.themes_host.should eql(themes_host) }
  end

  describe "setting host directly ovevrrides the defaults" do
    let(:cfs_host) { "new.cfs.exvo.com" }
    let(:desktop_host) { "new.exvo.com" }
    let(:themes_host) { "new.themes.exvo.com" }

    before do
      Exvo.cfs_host = cfs_host
      Exvo.desktop_host = desktop_host
      Exvo.themes_host = themes_host
    end

    specify { Exvo.cfs_host.should eql(cfs_host) }
    specify { Exvo.desktop_host.should eql(desktop_host) }
    specify { Exvo.themes_host.should eql(themes_host) }
  end

end
