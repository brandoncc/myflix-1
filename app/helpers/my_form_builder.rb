class MyFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    options[:class] = "control-label col-sm-2"
    super
  end

  def text_field(method, *arg)
    error = object.errors[method].first
    options = {}
    options[:class] =  "form-control"
    arg << options
    super + error
  end

  def password_field(method, *arg)
    error = object.errors[method].first
    options = {}
    options[:class] =  "form-control"
    arg << options
    super + error
  end
end