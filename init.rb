require 'redmine'

Redmine::Plugin.register :redmine_coderwall do
  name 'Redmine Coderwall plugin'
  author 'Syntactic Vexation'
  description 'This is a plugin for Redmine that displays your coderwall achievements on My Page and user profile'
  version '0.3'
  requires_redmine version_or_higher: '4.0'
  url 'https://github.com/syntacticvexation/redmine_coderwall'
end

User.safe_attributes 'coderwall_alias'
User.safe_attributes 'coderwall_display_in_profile'

# initialize hook
class CoderwallAliasSettingsHook < Redmine::Hook::ViewListener
  render_on :view_my_account, :partial => 'coderwall_alias_settings'
  render_on :view_account_left_bottom, :partial => 'my/blocks/coderwall_box'
end
