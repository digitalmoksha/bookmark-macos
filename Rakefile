# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")

require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'bookmark-macos'
  app.deployment_target = '14.0'
  app.info_plist['CFBundleIconName'] = 'AppIcon'

  app.entitlements['com.apple.security.app-sandbox']                    = true
  app.entitlements['com.apple.security.files.bookmarks.app-scope']      = true
  app.entitlements['com.apple.security.files.user-selected.read-write'] = true
end
