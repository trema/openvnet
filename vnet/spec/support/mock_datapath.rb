# -*- coding: utf-8 -*-
class MockDatapath < Vnet::Openflow::Datapath
  attr_reader :sent_messages
  attr_reader :added_flows
  attr_reader :added_ovs_flows
  attr_reader :added_tunnels

  def initialize(*args)
    super(*args)
    @sent_messages = []
    @added_flows = []
    @added_ovs_flows = []
    @added_tunnels = []
  end

  def send_message(message)
    @sent_messages << message
  end

  def add_flow(flow)
    @added_flows << flow
  end

  def add_flows(flows)
    @added_flows += flows
  end

  def add_ovs_flow(ovs_flow)
    @added_ovs_flows << ovs_flow
  end

  def add_tunnel(tunnel_name, remote_ip)
    @added_tunnels << {:tunnel_name => tunnel_name, :remote_ip => remote_ip}
  end
end