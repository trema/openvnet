# -*- coding: utf-8 -*-
require 'spec_helper'

describe Vnet::Configurations::Vna do
  let(:config_path) { File.join(Vnet::ROOT, "spec/config") }

  before do
    allow(Vnet::Configurations::Vna).to receive(:paths).and_return([config_path])
  end

  describe "param" do
    subject { Vnet::Configurations::Vna.load }
    it { expect(subject.node.id).to eq "vna" }
    it { expect(subject.node.addr.protocol).to eq "tcp" }
    it { expect(subject.node.addr.host).to eq "127.0.0.1" }
    it { expect(subject.node.addr.port).to eq 19103 }
    it { expect(subject.node.addr_string).to eq "tcp://127.0.0.1:19103" }

    it { expect(subject.node_api_proxy).to eq :rpc }

    # trema
    it { expect(subject.trema_home).to eq Gem::Specification.find_by_name('trema').gem_dir }
    it { expect(subject.trema_tmp).to eq "/var/run/openvnet" }
  end
end
