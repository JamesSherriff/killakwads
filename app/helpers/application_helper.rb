module ApplicationHelper
  # Displays object errors
  def form_errors_for(object = nil)
    return render('layouts/form_errors', object: object) if object.errors.messages != {}
  end
end
