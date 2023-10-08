# bookmark-macos #

RubyMotion project which re-creates an error I'm having with `NSURL.URLByResolvingBookmarkData`.

## Instruction to recreate

Run the app with `rake`. You will probably get the dialog that says

> Do you want the application "bookmark-macos.app" to accept incoming network connections?

Click either `Allow` or `Deny`, it shouldn't matter. You will probably see the `Creating bookmark failed`
in the console.  Quit the app and run it again.

This time you will see the message `Creating bookmark was successful`. You will also see the
error that happens with `NSURL.URLByResolvingBookmarkData`

```
Objective-C stub for message `URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:' type `@@:@Q@*^@' not precompiled. Make sure you properly link with the framework or library that defines this message.
```

This only started happening when running on Sonoma, and is occurring out in the field.  I have not seen this
problem with 13.x and below.
