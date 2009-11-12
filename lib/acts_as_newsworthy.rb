module ActsAsNewsworthy

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_newsworthy(options={})
      range = options[:days] || 14
      field = options[:field] || :created_at
      
      instance_eval <<-DEFINE_METHODS
        def has_new_additions?
          !!self.first(:conditions => ['#{field} > ?', #{range}.days.ago.to_date])
        end
      DEFINE_METHODS
      
      class_eval <<-DEFINE_METHODS
        def new?
          #{field} >= #{range}.days.ago.to_date
        end
      DEFINE_METHODS
    end
  end
end