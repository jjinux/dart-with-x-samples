Dart with Google Web Toolkit
============================

This is an example of how to use Dart with GWT. It also makes use of Google
App Engine for Java.

Project URL: http://bit.ly/dart_with_gwt

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

Remember that to run the Dart code, you need to either use Dartium (that is,
the copy of Chromium that comes with Dart Editor), or you need to compile the
code to JavaScript using dart2js (which, again, can be done with Dart Editor).

When you deploy the code to Google App Engine, remember to compile both the
GWT code and the Dart code to JavaScript.

Interesting Files
-----------------

* `transcript.md` The transcript for a video I plan on recording to explain this sample.

* `src/org/dartlang/gwtapplication/client/GwtApplication.java` The main GWT application.

* `src/org/dartlang/gwtapplication/server/JsonServlet.java` A simple Java servlet that serves JSON.

* `war` The webroot. It contains CSS and HTML files.

* `war/dart_application` The Dart application. It has a pubspec.yaml in it.

* `war/dart_application/web/dart_application.dart` Where most of the Dart source code is.