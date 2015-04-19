module PersonasHelper
  def persona_badge(p)
    case p.persona_type.name
      when 'Primary Name'
        content_tag :span, 'Pri', class: 'badge'
      when 'Alternate Name'
        content_tag :span, 'Alt', class: 'badge'
      when 'Previous Name'
        content_tag :span, 'Old', class: 'badge'
    end
  end
end

