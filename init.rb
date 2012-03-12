require 'redmine'

Redmine::Plugin.register :redmine_coderwall do
  name 'Redmine Coderwall plugin'
  author 'Syntactic Vexation'
  description 'This is a plugin for Redmine that displays your coderwall achievements on My Page and user profile'
  version '0.1'
  url 'https://github.com/syntacticvexation/redmine_coderwall'
end

# Patches to the Redmine core
require 'dispatcher'

Dispatcher.to_prepare :redmine_coderwall do
  require_dependency 'application_helper'

  unless MyHelper.included_modules.include?(CoderwallHelperPatch)
    MyHelper.send(:include, CoderwallHelperPatch)
  end
  
   unless UsersHelper.included_modules.include?(CoderwallHelperPatch)
     UsersHelper.send(:include, CoderwallHelperPatch)
   end

  require_dependency 'principal'
  require_dependency 'user'
  User.safe_attributes 'coderwall_alias'
  User.safe_attributes 'coderwall_display_in_profile'
end

# initialize hook
class CoderwallAliasSettingsHook < Redmine::Hook::ViewListener
  render_on :view_my_account, :partial => 'coderwall_alias_settings'
  render_on :view_account_left_bottom, :partial => 'my/blocks/coderwall_box'
end