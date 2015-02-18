module PlansHelper
  def form_button_text_for(object)
    plan = object[1] if object.class == Array
    plan.new_record? ? "Create" : "Update"
  end
end
