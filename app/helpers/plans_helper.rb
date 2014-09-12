module PlansHelper
  def form_button_text_for(object)
    if object.class.find(object.id).nil?
      'Create'
    else
      'Update'
    end
  end

end
