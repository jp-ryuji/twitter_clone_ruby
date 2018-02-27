# frozen_string_literal: true

module ApplicationHelper
  def flash_messages
    return if flash.empty?
    capture do
      flash.each do |type, message|
        concat flash_message(type, message)
      end
    end
  end

  def flash_message(type, message)
    type = bootstrap_alert_class_for(type)
    content_tag :div, class: "alert #{type} alert-dismissible" do
      capture do
        concat content_tag(:button, '×', class: 'close', data: { dismiss: 'alert' })
        concat message
      end
    end
  end

  def bootstrap_alert_class_for(type)
    case type.to_sym
    when :success then 'alert-success'
    when :error then 'alert-danger'
    when :notice then 'alert-info'
    when :alert then 'alert-warning'
    else 'alert-info'
    end
  end

  def link_to_reset(resource = nil, path = nil, *filters, **options)
    # FIXME: Dangerous Send (User controlled method execution)
    path ||= send("#{params[:controller]}_path")
    return unless record_filtered?(resource, *filters)
    link_to 'Reset', path, options
  end

  def record_filtered?(resource, *filters)
    resource ||= params[:controller].singularize
    (params.fetch(resource, {}).keys.map(&:to_sym) & filters.flatten).any?
  end
end
