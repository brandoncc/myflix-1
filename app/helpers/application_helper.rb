module ApplicationHelper
  def my_form_for(record, options = {}, &block)
    options[:builder] = MyFormBuilder
    form_for(record, options, &block)
  end

  def options_for_rating_select(selected=nil)
    options_for_select((1..5).to_a.reverse.map { |n| [pluralize(n, 'star'), n] }, selected)
  end

  def options_for_category_select
    options_for_select(Category.all.map { |category| [category.name, category.id]})
  end
end
