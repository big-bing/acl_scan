Rails.application.routes.draw do
  mount AclScan::Engine => "/acl_scan"
end
