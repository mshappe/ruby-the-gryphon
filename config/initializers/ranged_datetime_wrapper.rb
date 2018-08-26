# frozen_string_literal: true

SimpleForm.setup do |config|
  config.wrappers :ranged_datetime, tag: 'div', class: 'form-group col-md-6', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly

    b.use :label, class: 'control-label'
    b.use :input, class: 'form-control'

    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :ranged_datetime_horiz, tag: 'div', class: 'col-lg-6 col-md-6', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly

    b.use :label, class: 'col-sm-3 control-label'
    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end
end
