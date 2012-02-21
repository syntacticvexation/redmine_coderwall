require 'redmine'

Redmine::Plugin.register :redmine_coderwall do
  name 'Redmine Coderwall plugin'
  author 'Syntactic Vexation'
  description 'This is a plugin for Redmine that displays your coderwall achievements on My Page'
  version '0.0.1'
  url 'https://github.com/syntacticvexation/redmine_coderwall'
end

# Patches to the Redmine core
require 'dispatcher'

Dispatcher.to_prepare :redmine_coderwall do
  require_dependency 'application_helper'

  unless MyHelper.included_modules.include?(CoderwallMyHelperPatch)
    MyHelper.send(:include, CoderwallMyHelperPatch)
  end

  require_dependency 'principal'
  require_dependency 'user'
  User.safe_attributes 'coderwall_alias'
end

# initialize hook
class CoderwallAliasSettingsHook < Redmine::Hook::ViewListener
  render_on :view_my_account, :partial => 'coderwall_alias_settings'
end