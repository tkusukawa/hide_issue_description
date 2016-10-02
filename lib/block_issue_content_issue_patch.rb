require_dependency 'issue'

module BlockIssueContentIssuePatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :visible?, :block_issue_content
    end
  end

  module InstanceMethods
    def visible_with_block_issue_content?(usr=nil)
      p caller
      visible = visible_without_block_issue_content?(usr)
      return false unless visible

      block = (usr || User.current).allowed_to?(:block_view_issue_content, self.project)
      return false if block

      return true
    end
  end
end
