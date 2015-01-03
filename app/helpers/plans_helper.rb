module PlansHelper
  def form_button_text_for(object)
    plan = object[1] if object.class == Array
    if plan.new_record?
      'Create'
    else
      'Update'
    end
  end

end
