module HideIssueDescriptionQueryPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :columns, :hide_issue_description
      alias_method_chain :available_block_columns, :hide_issue_description
      alias_method_chain :has_column?, :hide_issue_description
    end
  end

  module InstanceMethods
    def columns_with_hide_issue_description
      cols = []
      columns_without_hide_issue_description.each do |col|
        if (col.name != :description) ||
            (User.current.admin?) ||
            (! User.current.allowed_to?(:hide_view_issue_description, self.project))
          cols << col
        end
      end
      cols
    end

    def available_block_columns_with_hide_issue_description
      cols = []
      available_block_columns_without_hide_issue_description.each do |col|
        if (col.name != :description) ||
            (User.current.admin?) ||
            (! User.current.allowed_to?(:hide_view_issue_description, self.project))
          cols << col
        end
      end
      cols
    end

    def has_column_with_hide_issue_description?(column)
      column_name = column.is_a?(QueryColumn) ? column.name : column
      if (column_name == :description) &&
          (! User.current.admin?) &&
          User.current.allowed_to?(:hide_view_issue_description, self.project)
        return false
      end
      has_column_without_hide_issue_description?(column)
    end
  end
end
