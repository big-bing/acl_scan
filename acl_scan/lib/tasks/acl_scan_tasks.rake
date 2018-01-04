# desc "Explaining what the task does"
# task :acl_scan do
#   # Task goes here
# end
namespace :acl do

  desc "Scan controller ACL"
  task :scan => :environment do
    print "Start"
    begin_at = Time.now
    generate_abilities
    AclScan::Ability.delete_acl_cache
    puts "Scan ACL SUCCESS! Used #{Time.now - begin_at} seconds."
  end

  def generate_abilities
    # if Rails.env.development?
    Rails.application.eager_load!
    # end
    controllers = ApplicationController.descendants.to_a + AclScan::ApplicationController.descendants.to_a
    version = Time.now.to_i
    controllers.each do |ctrl|
      if ctrl.const_defined?(:ACL)
        acl = ctrl.const_get(:ACL)
        acl_build(acl, ctrl.to_s.tableize.singularize, version)
        print "."
      end
    end
  end

  def acl_build(acl, controller, version)
    controller.gsub!(/_controller/, '')

    acl[:acl] && acl[:acl].each do |ability_map|
      ability = AclScan::Ability.find_or_initialize_by(type_of: acl[:type],
                  module_name: acl[:module],
                  node_name: acl[:node],
                  unchangeable_name: ability_map.fetch(:unchangeable_name))
      ability.version = version
      ability.name = ability_map.fetch(:display_name)
      actions = ability_map.fetch(:actions).map do |action|
        "#{controller}:#{action}"
      end
      ability.actions = ability.actions.concat(actions).uniq
      ability.save!
    end

    if acl[:no_acl].present? && acl[:no_acl].is_a?(Array)
      ability = AclScan::Ability.find_or_initialize_by(type_of: acl[:type],
                  module_name: acl[:module],
                  node_name: acl[:node],
                  unchangeable_name: "#{controller}_no_acl")
      ability.version = version
      ability.name = ""
      actions = acl[:no_acl].map do |action|
        "#{controller}:#{action}"
      end
      ability.actions = actions
      ability.save!
    end

  end

end
