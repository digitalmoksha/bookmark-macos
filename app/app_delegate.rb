class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless

    bookmark = create_security_bookmark('/Library/RubyMotion/data')
    if bookmark
      puts 'Creating bookmark was successul'

      url = resolve_security_bookmark(bookmark)
      puts 'Resolving bookmark was successful' if url
    else
      puts 'Creating bookmark failed'
    end
  end

  def create_security_bookmark(url)
    url   = NSURL.fileURLWithPath(url) if url.is_a? String
    error = Pointer.new(:object)

    bookmark_data = url.bookmarkDataWithOptions(
      NSURLBookmarkCreationWithSecurityScope,
      includingResourceValuesForKeys: nil,
      relativeToURL: nil,
      error: error
    )

    unless bookmark_data
      msg = <<-MSG
        FileSystem.create_security_bookmark: #{error[0].localizedDescription}
          (code: #{error[0].code}, domain: #{error[0].domain}, userInfo: #{error[0].userInfo})
          #{url.path}
      MSG
      puts msg
    end

    bookmark_data
  end

  def resolve_security_bookmark(bookmark_data)
    error_path = nil
    is_stale   = Pointer.new(:boolean)
    error      = Pointer.new(:object)

    url = NSURL.URLByResolvingBookmarkData(bookmark_data,
                                           options: NSURLBookmarkResolutionWithSecurityScope,
                                           relativeToURL: nil,
                                           bookmarkDataIsStale: is_stale,
                                           error: error)

    unless url
      error_keys = NSURL.resourceValuesForKeys([NSURLPathKey], fromBookmarkData: bookmark_data)
      error_path = error_keys['_NSURLPathKey']
      msg = <<-MSG
        FileSystem.resolve_security_bookmark: #{error[0].localizedDescription}
          (code: #{error[0].code}, domain: #{error[0].domain}, userInfo: #{error[0].userInfo})
          #{error_path}
          stale?: #{is_stale[0]}
      MSG
      puts msg
    end

    { url: url, is_stale: is_stale[0], error_path: error_path }
  end
end
