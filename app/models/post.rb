class Post < ActiveRecord::Base

  # Filter the result according to the parameters
  def self.filter(attributes)
    attributes.reduce(all) do |scope, (key, value)|
      return scope if value.blank?
      case key.to_sym
      when :author # direct search
        scope.where(key => value)
      when :from
        scope.where("date > ?", value)
      when :to
        scope.where("date < ?", value)
      else # unknown key (do nothing or raise error, as you prefer to)
        scope
      end
    end
  end

end
