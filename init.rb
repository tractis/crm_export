require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_export, initializer) do
          name "Fat Free CRM Export"
       authors "Tractis - Jose Luis Gordo Romero"
       version "0.1"
   description "Export Contacts"
  dependencies :haml
end

require "crm_export"
