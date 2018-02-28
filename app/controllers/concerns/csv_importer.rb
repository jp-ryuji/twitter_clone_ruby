# frozen_string_literal: true

module CsvImporter
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/AbcSize
  def import_csv
    if params[:file].blank?
      redirect_to(redirect_path, alert: 'Specify a csv file to import')
      return
    end

    importer = csv_importer_class.new(params[:file])
    importer.import

    if importer.errors.present?
      redirect_to redirect_path, alert: importer.errors.full_messages.join(', ')
    else
      redirect_to redirect_path, notice: 'Csv file was successfully imported.'
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def model_name
    @model_name ||= params[:controller].gsub('admin/', '').classify
  end

  def csv_importer_class
    "#{model_name.pluralize}CsvImporter".constantize
  end

  def redirect_path
    send "admin_#{model_name.tableize}_path"
  end
end
