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

src/org/dartlang/gwtapplication/client/GwtApplication.java
	This is the main GWT application.

src/org/dartlang/gwtapplication/server/JsonServlet.java
	This is a simple Java servlet that serves JSON.

war
	This is the webroot. It contains CSS and HTML files.

war/dart_application
	This is the Dart application. It has a pubspec.yaml in it.

war/dart_application/web/dart_application.dart
	This is where most of the Dart source code is.