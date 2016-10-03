require_dependency 'issue'

module HideIssueDescriptionIssuePatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :visible?, :hide_issue_description
    end
  end

  module InstanceMethods
    def visible_with_hide_issue_description?(usr=nil)

      return false unless visible_without_hide_issue_description?(usr)
      return true if (usr || User.current).admin?
      return false if (usr || User.current).allowed_to?(:hide_view_issue_description, self.project)

      return true
    end
  end
end
