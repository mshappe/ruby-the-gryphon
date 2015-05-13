module PersonasHelper
  def persona_badge(p)
    case p.persona_type.name
      when 'Primary Name'
        content_tag :span, 'Pri', class: 'label label-default'
      when 'Alternate Name'
        content_tag :span, 'Alt', class: 'label label-default'
      when 'Previous Name'
        content_tag :span, 'Old', class: 'label label-default'
    end
  end
end

