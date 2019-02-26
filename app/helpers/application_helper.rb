module ApplicationHelper
  # Displays object errors
  def form_errors_for(object = nil)
    puts object.errors.inspect
    return render('layouts/form_errors', object: object) if object.errors.details != {}
  end
end
