# -*- coding: utf-8 -*-

module Vnet::Openflow::Ports
  module Generic
    include Vnet::Openflow::FlowHelpers

    def port_type
      :generic
    end

    def flow_options
      @flow_options ||= {:cookie => @cookie}
    end

    def install
      flows = []
      flows << Flow.create(TABLE_CLASSIFIER, 2, {
                            :in_port => self.port_number
                           }, nil, flow_options.merge({:goto_table => TABLE_EDGE_SRC}))
      @datapath.add_flows(flows)
    end
  end
end
