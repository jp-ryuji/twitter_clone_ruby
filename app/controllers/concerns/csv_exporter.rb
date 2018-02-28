# frozen_string_literal: true

module CsvExporter
  extend ActiveSupport::Concern

  def export_csv
    records = search_form_class.new(search_params).search
    csv_exporter = csv_exporter_class.new(records)
    send_data csv_exporter.export, filename: "#{model_name.tableize}.csv"
  end

  private

  def model_name
    @model_name ||= params[:controller].gsub('admin/', '').classify
  end

  def search_form_class
    "Admin::#{model_name.pluralize}SearchForm".constantize
  end

  def csv_exporter_class
    "#{model_name.pluralize}CsvExporter".constantize
  end

  def search_params
    raise NotImplementedError, "#{__method__} should be implemented"
  end
end
