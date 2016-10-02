require 'redmine'

require_dependency 'block_issue_content_issue_patch'

Rails.configuration.to_prepare do
  unless Issue.included_modules.include?(BlockIssueContentIssuePatch)
    Issue.send(:include, BlockIssueContentIssuePatch)
  end
end

Redmine::Plugin.register :block_issue_content do
  name 'Block Issue Content plugin'
  author 'Tomohisa Kusukawa'
  description 'Redmine plugin to block the view of issue content'
  version '0.0.1'
  url 'https://github.com/tkusukawa/block_issue_content'
  author_url 'https://github.com/tkusukawa'

  project_module :issue_tracking do
    permission :block_view_issue_content, {}
  end
end
