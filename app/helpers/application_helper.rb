module ApplicationHelper
  def my_form_for(record, options = {}, &block)
    options[:builder] = MyFormBuilder
    form_for(record, options, &block)
  end
  def options_for_rating_select(selected=nil)
    options_for_select([["5 Stars", 5], ["4 Stars", 4], ["3 Stars", 3], ["2 Stars", 2], ["1 Star", 1]], selected)
  end
end
