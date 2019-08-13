# mactouchsender
A tiny Cocoa application, that sends information about curse positions and touchpad pressure as UDP datagrams

# Usage

Build in XCode and either Run there or create an app Archive and run that.

To see output use:
```bash
nc -u -l 127.0.0.1 45679
```

That should print *time, position, pressure* information when the touchpad is pressed in the app's window.
