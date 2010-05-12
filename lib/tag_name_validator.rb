class TagNameValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    otherfield = attribute == 'label_it' ? 'label_en' : 'label_it'
    tag = Tag.find(:first, :conditions => ["id != ? AND #{otherfield} like ?", object.id, value])
    unless tag.nil?
      object.errors[attribute] << (options[:message] || "is not formed properly")
    end
  end
end
