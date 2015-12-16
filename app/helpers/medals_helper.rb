module MedalsHelper
  def medsort()
    if admin_signed_in?
      return 'sortable'
    end
  end
end

