# -*- coding: utf-8 -*-
require 'spec_helper'
require "ipaddr"

describe Vnet::NodeApi::TranslationStaticAddress do
  before do
    use_mock_event_handler
  end

  let(:public_network) { Fabricate(:pnet_public1) }
  let(:virtual_network) { Fabricate(:vnet_1) }

  let(:ip_address_gw) do
    net = public_network
    Fabricate(:ip_address_any) do
      ipv4_address { IPAddr.new("192.168.1.2").to_i }
      network { net }
    end
  end

  let(:ip_lease_gw) do
    network = public_network
    ipaddr = ip_address_gw
    Fabricate(:ip_lease_any) do
      ip_address_id { ipaddr.id }
      network_id { network.id }
    end
  end

  let(:outer_network_gw) do
    ilg = ip_lease_gw
    Fabricate(:interface_w_mac_lease, mode: "simulated") do
      ip_leases { [ilg] }
    end
  end

  let(:translation) do
    ogw = outer_network_gw
    Fabricate(:translation) do
      interface { ogw }
    end
  end

  let(:route_link) { Fabricate(:route_link) }
  let(:ingress_ipv4_address) { "192.168.1.155" }
  let(:egress_ipv4_address) { "10.102.0.10" }

  describe "create" do
    it "creates ip_lease" do
      params = {
        translation_id: translation.id,
        route_link_id: route_link.id,
        ingress_ipv4_address: ingress_ipv4_address,
        egress_ipv4_address: egress_ipv4_address
      }
      Vnet::NodeApi::TranslationStaticAddress.create(params)

      expect(Vnet::NodeApi::TranslationStaticAddress.all).not_to eq []
    end
  end
end
