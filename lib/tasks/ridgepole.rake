# frozen_string_literal: true

namespace :ridgepole do
  desc 'Apply database schema'
  task apply: :environment do
    ridgepole('--apply')
  end

  desc 'Export database schema'
  task export: :environment do
    ridgepole('--export')
  end

  private

  def ridgepole(*options)
    command = ['bundle exec ridgepole -f db/Schemafile', '-c config/database.yml', "-E #{Rails.env}"]
    system((command + options).join(' '))

    # rubocop:disable Style/GuardClause
    unless Rails.env.production?
      Rake::Task['db:schema:dump'].invoke
      Rake::Task['db:test:prepare'].invoke
      # Rake::Task['annotate_models'].invoke
      Rails.root.join('db/schema.rb').delete
    end
    # rubocop:enable Style/GuardClause
  end
end
