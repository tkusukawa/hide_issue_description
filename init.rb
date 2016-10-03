require 'redmine'

require_dependency 'hide_issue_description_issue_patch'
require_dependency 'hide_issue_description_query_patch'

Rails.configuration.to_prepare do
  unless Issue.included_modules.include?(HideIssueDescriptionIssuePatch)
    Issue.send(:include, HideIssueDescriptionIssuePatch)
  end
  unless Query.included_modules.include?(HideIssueDescriptionQueryPatch)
    Query.send(:include, HideIssueDescriptionQueryPatch)
  end
end

Redmine::Plugin.register :hide_issue_description do
  name 'Hide Issue Description plugin'
  author 'Tomohisa Kusukawa'
  description 'Redmine plugin to hide the view of issue description'
  version '0.0.4'
  url 'https://github.com/tkusukawa/hide_issue_description'
  author_url 'https://github.com/tkusukawa'

  project_module :issue_tracking do
    permission :hide_view_issue_description, {}
  end
end
