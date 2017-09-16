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
end
