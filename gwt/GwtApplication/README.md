Dart with Google Web Toolkit
============================

This is an example of how to use Dart with GWT. It also makes use of Google
App Engine for Java.

Setup
-----

This is a GWT application. See
[these instructions](https://developers.google.com/web-toolkit/usingeclipse)
for information on setting up GWT using Eclipse as well as how to
deploy to Google App Engine.

Inside `war/dart_application` is a Dart application.
See [this page](http://www.dartlang.org/downloads.html)
to download either the Dart Editor or the Dart SDK.
You can open up `war/dart_application` using Dart Editor,
or you can run the following to make sure all the Dart
dependencies are installed:

	$ (cd war/dart_application && pub install)

Interesting Files
-----------------

* `transcript.md` The transcript for a video I plan on recording to explain this sample.

* `src/org/dartlang/gwtapplication/client/GwtApplication.java` The main GWT application.

* `src/org/dartlang/gwtapplication/server/JsonServlet.java` A simple Java servlet that serves JSON.

* `war` The webroot. It contains CSS and HTML files.

* `war/dart_application` The Dart application. It has a pubspec.yaml in it.

* `war/dart_application/web/dart_application.dart` Where most of the Dart source code is.