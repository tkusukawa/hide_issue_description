module BlockIssueContentQueryPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :columns, :block_issue_content
      alias_method_chain :available_block_columns, :block_issue_content
      alias_method_chain :has_column?, :block_issue_content
    end
  end

  module InstanceMethods
    def columns_with_block_issue_content
      cols = []
      columns_without_block_issue_content.each do |col|
        if (col.name != :description) ||
            (User.current.admin?) ||
            (! User.current.allowed_to?(:block_view_issue_content, self.project))
          cols << col
        end
      end
      cols
    end

    def available_block_columns_with_block_issue_content
      cols = []
      available_block_columns_without_block_issue_content.each do |col|
        if (col.name != :description) ||
            (User.current.admin?) ||
            (! User.current.allowed_to?(:block_view_issue_content, self.project))
          cols << col
        end
      end
      cols
    end

    def has_column_with_block_issue_content?(column)
      column_name = column.is_a?(QueryColumn) ? column.name : column
      if (column_name == :description) &&
          (! User.current.admin?) &&
          User.current.allowed_to?(:block_view_issue_content, self.project)
        return false
      end
      has_column_without_block_issue_content?(column)
    end
  end
end
