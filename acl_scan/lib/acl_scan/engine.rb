module AclScan
  class Engine < ::Rails::Engine
    isolate_namespace AclScan

    # run bundle exec rake db:migrate 可以migrate core 内部的 migrations
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :slim
    end

    config.time_zone = 'Beijing'

  end
end
