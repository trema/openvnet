# -*- coding: utf-8 -*-

Vnet::Endpoints::V10::VnetAPI.namespace '/topologies' do
  def self.put_post_shared_params
  end

  put_post_shared_params
  param_uuid M::Topology
  param :mode, :String, in: C::Topology::MODES
  post do
    post_new(:Topology)
  end

  get do
    get_all(:Topology)
  end

  get '/:uuid' do
    get_by_uuid(:Topology)
  end

  delete '/:uuid' do
    delete_by_uuid(:Topology)
  end

  put_post_shared_params
  put '/:uuid' do
    update_by_uuid(:Topology)
  end

  post '/:uuid/networks/:network_uuid' do
    topology = uuid_to_id(M::Topology, "uuid", "topology_id")
    network = uuid_to_id(M::Network, "network_uuid", "network_id")

    remove_system_parameters

    result = M::TopologyNetwork.create(params)
    respond_with(R::TopologyNetwork.generate(result))
  end

  get '/:uuid/networks' do
    show_relations(:Topology, :topology_networks)
  end

  delete '/:uuid/networks/:network_uuid' do
    topology = check_syntax_and_pop_uuid(M::Topology)
    network = check_syntax_and_pop_uuid(M::Network, 'network_uuid')

    M::TopologyNetwork.destroy(topology_id: topology.id, network_id: network.id)

    respond_with([network.uuid])
  end

end