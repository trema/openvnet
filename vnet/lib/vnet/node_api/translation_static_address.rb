# -*- coding: utf-8 -*-

module Vnet::NodeApi
  class TranslationStaticAddress < EventBase
    class << self
      private

      def create_with_transaction(options)
        transaction do
          model = internal_create(options)
          gw = model_class(:translation)[options[:translation_id]].interface || return

          ip = model_class(:ip_address).create(ipv4_address: options[:ingress_ipv4_address],
                                               network_id: gw.ip_leases.first.network.id)

          model_class(:ip_lease).create(mac_lease_id: gw.mac_leases.first.id,
                                        ip_address_id: ip.id,
                                        interface_id: gw.id,
                                        enable_routing: true)
          model
        end
      end

      def dispatch_created_item_events(model)
        model_hash = model.to_hash.merge(id: model.translation_id,
                                         static_address_id: model.id)

        dispatch_event(TRANSLATION_ADDED_STATIC_ADDRESS, model_hash)
      end

      def dispatch_deleted_item_events(model)
        dispatch_event(TRANSLATION_REMOVED_STATIC_ADDRESS,
                       id: model.translation_id,
                       static_address_id: model.id)
      end

    end
  end
end
