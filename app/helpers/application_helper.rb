module ApplicationHelper

  def alert_type(flash_type)
    case flash_type
    when 'alert' then 'danger'
    when 'notice' then 'primary'
    end
  end
end
