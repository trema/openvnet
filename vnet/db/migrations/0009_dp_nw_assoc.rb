# -*- coding: utf-8 -*-

Sequel.migration do
  up do

    create_table(:interface_networks) do
      primary_key :id

      Integer :interface_id, :null => false
      Integer :network_id, :null => false

      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      DateTime :deleted_at, :index => true
      Integer :is_deleted, :null=>false, :default=>0

      unique [:interface_id, :network_id, :is_deleted]
    end

  end

  down do
    drop_table(:interface_networks,
              )
  end
end
