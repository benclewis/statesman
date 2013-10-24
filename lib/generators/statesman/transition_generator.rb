require "rails/generators"

module Statesman
  class TransitionGenerator < Rails::Generators::Base
    desc "Create a transition model with the required attributes"

    argument :parent, type: :string, desc: "Your parent model name"
    argument :klass, type: :string, desc: "Your transition model name"

    source_root File.expand_path('../templates', __FILE__)

    def create_model_file
      template("create_migration.rb.erb", migration_file_name)
      template("transition_model.rb.erb", model_file_name)
    end

    private

    def next_migration_number
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    def migration_file_name
      "db/migrate/#{next_migration_number}_create_#{table_name}.rb"
    end

    def model_file_name
      "app/models/#{klass.underscore}.rb"
    end

    def table_name
      klass.underscore.pluralize
    end

    def parent_id
      parent.underscore + "_id"
    end
  end
end
