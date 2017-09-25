module ApplicationHelper
  def my_form_for(record, options = {}, &block)
    options[:builder] = MyFormBuilder
    form_for(record, options, &block)
  end
end
