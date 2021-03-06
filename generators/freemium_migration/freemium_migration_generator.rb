class FreemiumMigrationGenerator < Rails::Generator::NamedBase
  def initialize(runtime_args, runtime_options = {})
    runtime_args.insert(0, 'migrations')
    super
  end

  def manifest
    record do |m|
      m.migration_template "migration.rb", "db/migrate", :migration_file_name => "create_freemium_models"
      m.template "config.rb", "config/initializers/freemium.rb"
      m.template "freemium_feature_sets.yml", "config/freemium_feature_sets.yml"

      %w(coupon coupon_redemption credit_card subscription subscription_plan subscription_change transaction).each do |model|
        m.template "#{model}.rb", "app/models/freemium_#{model}.rb"
      end
    end
  end
end
