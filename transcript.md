Transcript
==========

Video: Dart Intro Video
-----------------------

Slide: Dart with Google Web Toolkit
-----------------------------------

Hi, my name is JJ Behrens. I'm a developer advocate for Dart. In this episode
of Dartisans, I'm going to show you how to use Dart with Google Web Toolkit.

In order to demonstrate how to get Dart and GWT to work together, I've built a
sample application. The sample also makes use of Google App Engine for Java.

If you want to check out the sample, you can can download the source code at:

http://bit.ly/YBwheM.

Slide: Setting up Your Development Environment
----------------------------------------------

I used Eclipse and Dart Editor to build the sample application.

Demo: Show: https://developers.google.com/web-toolkit/usingeclipse
------------------------------------------------------------------

If you're a GWT developer, you're probably already very familiar with how to
install Eclipse, so I won't bore you with that. The GWT website has some
pretty decent instructions.

Demo: Show: http://www.eclipse.org/downloads/
---------------------------------------------

I used the Juno release of the "Eclipse IDE for Java EE Developers".

Demo: Show: https://developers.google.com/web-toolkit/usingeclipse#installing
-----------------------------------------------------------------------------

Then I installed the Google Plugin for Eclipse. I decided to install
everything, but the most important things are "Google Web Toolkit" and "Google
App Engine Java SDK".

The instructions also walk you through installing "Google Web Toolkit
Developer Plugin" for Chrome.

Demo: Show: http://www.dartlang.org
-----------------------------------

To install Dart, head on over to dartlang.org. I used Dart Editor to build the
sample application.

Demo: Show: http://www.dartlang.org/docs/editor/getting-started/
----------------------------------------------------------------

If you've never installed Dart Editor before, there's a Getting Started guide.

Slide: .bashrc
--------------

I like to use dart and pub from the command line, so I have the following in
my .bashrc:

export DART_SDK=~/Local/dart/dart-sdk
export PATH=$PATH:~/Local/dart/dart-sdk/bin

However, you can also rely on Dart Editor to run pub for you.

Demo: Show Dart Editor
----------------------

Dart Editor is based on Eclipse components, so it kind of looks like a very
stripped down version of Eclipse.

You might be wondering why I don't use the Dart Editor plugin for Eclipse.
Unfortunately, it's not yet as polished as Dart Editor is. I recommend keeping
Dart Editor separate of Eclipse for the time being, until things settle down
and a few key bugs get fixed.

Using Eclipse to edit Java and Dart Editor to edit Dart actually works out
pretty well for me. You can still use Eclipse with the EGit plugin to commit
your Dart files to Git, but I tend to use the command line to interact with
Git because that's where I'm most comfortable.

Demo: Creating a GWT Application
--------------------------------

GWT and Dart each have their own requirements for how your project should be
laid out. Let's start by creating a GWT application. Make sure you include
support for Google App Engine.

Demo: Creating a Dart application using Dart Editor
---------------------------------------------------

Now, let's setup the Dart application. The `war` directory is where all the
static files go, so that's where the Dart application needs to go.

Make sure you make it a web application and include support for pub.

I'm going to get rid of the HTML file and empty out the Dart file for the time
being.

Notice that I'm using Dart Editor to manage a Dart project that is embedded
within my GWT project.

Demo: Show .gitignore in Sublime Text 2
---------------------------------------

By the way, if you're using Git, here's my .gitignore file.

Demo: Empty Out the Sample GWT Code
-----------------------------------

Now, let's get rid of most of the sample GWT code that Eclipse created.

You have to do it in the right order, or you'll get errors.

Remember to delete the reference to the servlet in web.xml or else the app
won't start correctly.

I'm going to mostly empty out the GwtApplication class.

Demo: Start up the Server
-------------------------

To fire up the GWT application in Eclipse, right click on the application in
the left-hand pane, and select "Debug as: (Google) Web Application".

You can double click on the URL to view the page in Chrome. If you haven't yet
installed the Google Web Toolkit plugin for Chrome, it'll walk you through
that.

Remember, GWT takes a little while to fire up.

Demo: Edit GwtApplication.html
------------------------------

Now, let's edit the HTML file in the war directory.

First, I'll get rid of most of the comments so that it's easier to see what's
going on.

Then, I'll include the right script references to load the Dart app. Notice,
that first I include a reference to the Dart file. Then I include a reference
to the dart.js file. The dart.js file is responsible for figuring out if the
browser can execute Dart natively or whether the browser should load the
JavaScript code that's been compiled from the Dart.

Demo: Show pubspec.yaml
-----------------------

The dart.js file gets created by pub thanks our dependency on the "browser"
package.

Demo: Edit GwtApplication.html
------------------------------

Now, let's add some HTML to the HTML page. I'll create some divs that GWT and
Dart can tie into.

It's perfectly acceptable for GWT and Dart to manage different parts of the
same HTML page.

Later, I'll show how they can interact even more closely thanks to JavaScript
interoperability.

Demo: Edit GwtApplication.java
------------------------------

Now let's do "Hello World" in GWT by having GWT print something to the page.

I've added a VerticalPanel to the gwtDiv.

I've also created a printString method that can add new labels to the
VerticalPanel.

Let's try it out. Great! GWT is now interacting with the HTML page.

Demo: Show dart_application.dart in Eclipse
-------------------------------------------

Now, let's do the same thing in Dart.

Let's edit the dart_application.dart file that lives deep within GWT's `war`
directory.

However, let's edit it in Dart Editor.

Demo: Show dart_application.dart in Dart Editor
-----------------------------------------------

We already setup the HTML file to include this Dart file. Now, let's create a
main() function.

First, I'll query for the dartDiv.

Then, I'll create a printString method like I did for GWT. Notice that cool
method cascade syntax that saves me from writing div two times. Also notice
that I'm setting the text property of the DivElement rather than the innerHtml
property. That way I don't have to worry about cross-site scripting attacks.

Now we can call printString to say that the Dart application has loaded.

At this point, I could compile the Dart to JavaScript. However, during
development, it's much faster to run the code in Dartium.

Demo: Execute the Code in Dartium
---------------------------------

Copy the URL for the app from Eclipse, and open up the copy of Chromium (aka
Dartium) that came with Dart editor.

If this is the first time, you may need to install the "Google Web Toolkit
Developer Plugin" into Dartium.

If everything went smoothly, we should see the output from Dart in the context
of our GWT application running in Dartium. Fantastic!

Slide: Using Dart to Talk to a Java Servlet
-------------------------------------------

If you're using GWT, it's very likely you have Java on the server too. Hence,
it's important that your Dart code be able to talk to your Java code on the
server.

If you're used to using GWT, you may be accustomed to using GWT RPC to talk to
your Java Servlets. Unfortunately, that's not an option for Dart. The protocol
is very specific to GWT and Java.

However, you can certainly generate JSON using your Java servlet and then consume
that JSON from Dart using an XMLHttpRequest. It's not as slick as GWT RPC, but it
definitely works.

Let me show you how to do that.

Demo: JsonServlet.java
----------------------

Here is the code for a servlet that serves JSON. In this code, I'm hardcoding
the JSON, but naturally, you can generate the JSON dynamically using a JSON
library.

Demo: web.xml
-------------

In order to make ues of JsonServlet.java, you have to edit web.xml in order to
tie the servlet to a particular HTTP path.

This requires a servlet tag and servlet-mapping tag.

Notice the URL that I used.

Demo: View the JSON generated by the servlet in Dartium
-------------------------------------------------------

Let's restart the application and check to make sure that the servlet is
actually generating the JSON correctly.

I can view this URL (http://127.0.0.1:8888/gwt_application/json_servlet) in
Dartium. Good, the servlet is generating JSON correctly.

Demo: dart_application.dart
---------------------------

Now let's look at dart_application.dart in Dart Editor. I use
HttpRequest.getString() to fetch a URL. Rather than take a callback, it
returns a Future object. I register a success handler using the then() method,
and an error handler using catchError(). The use of futures is pretty
pervasive in Dart, both on the client side as well as the server side, so this
code will look familiar if you're a Dart developer.

In this code, I'm just printing out the JSON response, but it's trivial to
parse it using the "dart:json" library.

Slide: Getting Dart and GWT to talk to one another
--------------------------------------------------

Now that we've covered getting Dart to talk to your Java server, let's cover
how to get Dart and  GWT to talk to one another.

One approach that HTML5 provides for getting different things to talk to each
in other in a browser is window.postMessage. You can use window.postMessage
for lots of things such as communicating with Native Client or getting web
pages from different domains to communicate.

It's also one way of getting Dart and GWT to talk to one another.

Slide: Using postMessage to get Dart and GWT to communicate
-----------------------------------------------------------

In the following, I'm going to show you 6 pieces of code:

1. How to call postMessage from GWT.
2. How to call postMessage from Dart.
3. How to listen for postMessage from GWT.
4. How to listen for postMessage from Dart.
5. How to create a button to generate a postMessage from GWT.
6. How to create a button to generate a postMessage from Dart.

Once that's all done, I'll show it to you working.

Demo: How to call postMessage from GWT
--------------------------------------

First let me show you how to call postMessage from GWT. This requires JSNI,
the JavaScript Native Interface for GWT.

I create a method called postMessage that takes a String msg. Notice that I
used the native keyword. The body of the method is a weird mix of JavaScript
and JSNI. In order to call window.postMessage, I have to call
$wnd.postMessage.

Demo: How to call postMessage from Dart
--------------------------------------

Now, let me show you how to call postMessage from Dart. It's actually really
easy because Dart provides an API. I just call window.postMessage.

Demo: How to listen for postMessage from GWT
--------------------------------------------

Now, let me show you how to listen for message events in GWT. Let's start by
calling a new method called listenForPostMessage() in onModuleLoad().

Now I have to implement listenForPostMessage(). Just like before, this
requires JSNI which is why I had to pull the code for listenForPostMessage()
out of onModuleLoad() and into its own method.

The key part is $wnd.addEventListener, where we listen for message events.
That takes a callback. Notice that I have to set "var that = this". This is a
little JavaScript trick that's necessary because of a weird scoping issue in
JavaScript.

Inside the addEventListener listener, there's a really long piece of code that
has a fully qualified class name. This is the JSNI code necessary to call back
into Java. I call from JavaScript into my onPostMessage which is a simple Java
method. The nice thing is that JSNI takes care of casting the data to the right
types when calling onPostMessage.

Inside onPostMessage, I just print a string saying that GWT has received a
postMessage.

Demo: How to listen for postMessage from Dart
---------------------------------------------

Here's how to listen for postMessage in Dart. Once again, Dart provides an
API, so it's pretty easy. I just call window.onMessage.listen and pass a
callback. Notice the convenient function expression syntax, the use of triple
quotes, and the use of string interpolation.

Demo: How to create a button to generate a postMessage from GWT
---------------------------------------------------------------

Now, let's create a button in GWT. Clicking on the button will send a
postMessage. This code is fairly straightforward. It just calls the
postMessage method that we wrote earlier.

Demo: How to create a button to generate a postMessage from Dart
----------------------------------------------------------------

Now let's look at the Dart code to do the same thing. I create a new
ButtonElement and set some properties on it. I add the gwt-Button class to it
to make sure it looks the same as the button I created in GWT. My onClick
listener just calls window.postMessage directly.

Demo: Using postMessage to get Dart and GWT to talk
---------------------------------------------------

Let's see if everything works. First I'll restart the server (just in case).
Then, I'll reload the page in Dartium.

I click on each of the buttons to generate a postMessage from GWT and from
Dart. Great! It works.

Notice that it doesn't matter who sends the postMessage, both sides receive
it. That's just something you have to keep in mind when you use postMessage
the way we're using it. From the browser's perspective, there's no difference
between whether Dart or GWT is calling window.postMessage.

By the way, I'm kind of ignoring the origin of the postMessage. You can read
more about postMessage online to learn about the security implications of
properly checking the origin, but that's outside the scope of this tutorial.

Slide: Using JavaScript as an intermediary between Dart and GWT
---------------------------------------------------------------

postMessage is a useful tool to have in your toolbox because it can work in a
variety of situations such as using Native Client or getting pages from different
domains to talk with one another.

However, since Dart and GWT both have an API for JavaScript interoperability,
you can use JavaScript as an intermediary between Dart and GWT.

This is actually more subtle than it sounds. So far, we haven't been compiling
Dart to JavaScript. Dartium understands Dart natively. To some extent, this is
true of GWT in development mode as well. Nonetheless, Dart's JavaScript
interoperability library works whether the browser is interpreting Dart or
JavaScript.

Slide: Using JavaScript as an intermediary between Dart and GWT
---------------------------------------------------------------

Rather than show you how to put a single callback function on the window
object, I'm going to show you how to create a JavaScript module so that you
can have lots of callback functions. Hence, I'm going to show you four things:

1. How to create a JavaScript module and a callback function in GWT.
2. How to create a JavaScript module and a callback function in Dart.
3. How to call the Dart callback from GWT.
4. How to call the GWT callback from Dart.

Just like I did for postMessage, I'll create a button on each side that the
user can click on in order to invoke the callbacks.

Demo: How to create a JavaScript module and a callback function in GWT
----------------------------------------------------------------------

First let's start with GWT. In onModuleLoad(), I'll call a new method,
initGwtApplicationModule(). initGwtApplicationModule() is implemented using
JSNI.

I set $wnd.gwtApplicationModule to a new JavaScript object that contains a
single method, gwtCallback(). gwtCallback() is a JavaScript method that calls
a Java method that is also called gwtCallback().

Hence, with just a little bit of JSNI code, I've setup a JavaScript module
where I can add as many callbacks as I need, and I can implement those
callbacks using Java.

To make it even more realistic, the gwtCallback() method takes three
parameters, an int, a String, and a JavaScriptObject. I did this to show
you that Dart and GWT can pass complex JavaScript objects back and forth to
each other. Finally, the gwtCallback() method returns a String.

There's another interesting thing to notice. The Java version of gwtCallback()
receives a JavaScriptObjectPassedFromDart instance rather than a
JavaScriptObject instance. This is based on GWT's notion of JavaScript overlay
types. The JavaScriptObjectPassedFromDart class extends JavaScriptObject, and
it adds a hello() method implemented in JSNI so that Java code can interact
more easily with the JavaScript object passed from Dart.

As a final comment, unlike with postMessage where the message was asynchronous
and went to everyone listening for messages, in this case, the callback is
synchronous, only goes to a single listener, and even has a return value.
Nonetheless, the implementation isn't too different from the code we used for
postMessage.

Demo: How to create a JavaScript module and a callback function in Dart
-----------------------------------------------------------------------

Over on the Dart side, the code looks very different.

Demo: pubspec.yaml
------------------

First I have to add the js package as a dependency in my pubspec.yaml. Dart
Editor recognizes when I change pubspec.yaml and will automatically run "pub
install" for me to update my dependencies.

Demo: How to create a JavaScript module and a callback function in Dart
-----------------------------------------------------------------------

Next, I have to add some code in dart_application.dart. I start by importing
the js package using the prefix "js".

Now let's look at the code for setting up the JavaScript module. In this code,
"js.context" is basically a reference to the JavaScript window object. I
create a new JavaScript object using js.map and I assign it to
js.context.dartApplicationModule. Then, inside the JavaScript object, I create
a new callback called dartCallback() that references a Dart function that is
also called dartCallback().

Notice that Dart's JavaScript interoperability API doesn't let you sling
little bits of JavaScript all over the place. Furthermore, the API requires
that you be a little bit more explicit about how memory is managed. For
instance, notice the use of js.scoped() which sets up a memory context. The
Dart team did it this way because dealing with distributed garbage collection
when you have two entirely separate VMs is a very difficult problem.

On the other hand, the Dart code is pure Dart. It's easy to create a
JavaScript object using js.map, and it's easy to setup a callback that will
call back into Dart using js.Callback. In this case, the callback might be
called many times instead of just once, so I use js.Callback.many() rather than
js.Callback.once().

By the way, the astute reader might be wondering if Dart has JavaScript
overlay types like GWT does. If you look at the Dart version of dartCallback,
you'll see that Dart can interact with the JavaScript object without needing
to create a specific JavaScript overlay type. That's because Dart uses a
js.Proxy object to act as a proxy object for the JavaScript object. This is
very convenient because it lets you use the JavaScript object as if it were a
native Dart object.

On the other hand, GWT's JavaScript overlay types do have one benefit--they
work very well with code completion in Eclipse. Code completion in Dart Editor
isn't particularly helpful with js.Proxy objects since js.Proxy is a dynamic
proxy which is based on Dart's noSuchMethod feature.

Demo: How to call the Dart callback from GWT
--------------------------------------------

Now, let's look at how to call the Dart callback from GWT.

Just like before, I setup a button that the user can click on in order to call
the callback. This button callback calls a JSNI method called
callDartCallback().

I can pass in an int and a String directly to callDartCallback(), but in
order to create a native JavaScriptObject, I use another JSNI method called
createObjectForCallback().

The createObjectForCallback() is a simple JSNI method that just returns an
opaque JavaScriptObject. Inside the method, you can see that the JavaScript
object itself is very simple.

The callDartCallback() method is a fairly simple JSNI method that takes an
int, a String, and the JavaScriptObject that we created in
createObjectForCallback(). Then it calls
$wnd.dartApplicationModule.dartCallback() which is pretty much how you'd call
the callback from JavaScript.

Notice that callDartCallback() returns the String that is returned by
the dartCallback().

Demo: How to call the GWT callback from Dart
--------------------------------------------

Now, let's look at the Dart code to invoke the GWT callback.

Once again, I create a ButtonElement.

This time, however, the onClick.listen() event handler makes use of the js
library in order to call js.context.gwtApplicationModule.gwtCallback. Remember
that js.context is Dart's reference to JavaScript's window object.

I pass three parameters to the gwtCallback() function, an int, a String, and a
JavaScript object which I create with js.map. Finally, I print the result of the
callback.

Demo: Show the callbacks working
--------------------------------

Ok, now that we have all the code, let's try it out. You can see that I can
call the Dart callback from GWT, and I can call the GWT callback from Dart. It
really is possible to get GWT and Dart to talk to each other! If you already
have a large GWT app, but you want to give Dart a try, you shouldn't feel like
you have to rewrite your whole app. You can dip your toes in the water to see
if you like it!

The next step is to compile the GWT code and the Dart code to JavaScript,
deploy it to Google App Engine, and try it out in a browser other than
Dartium. However, since there's nothing particularly new or difficult about
that, I'll leave it as an exercise for the reader.

Slide: Thanks for Watching!
---------------------------

As I was building this sample, I made heavy use of the GWT and Dart
documentation. I kept a list of links that I found particularly helpful. You
can get a full list of references in the video transcript, and you can also
download the sample source code from GitHub at:

	http://bit.ly/YBwheM

If you'd like to learn more about Dart, check out (http://dartlang.org).

If you have any questions about using Dart with GWT, post them to
StackOverflow using the tags "dart" and "gwt".

Thanks for watching!

Show my profile picture and (gplus.to/jjinux).

References
----------

Generating JSON on the server:
    https://developers.google.com/web-toolkit/doc/latest/tutorial/JSON

Calling to the server without using GWT RPC:
    https://developers.google.com/web-toolkit/doc/latest/FAQ_Server#How_do_I_make_a_call_to_the_server_if_I_am_not_using_GWT_RPC?

Consuming JSON from Dart:
	http://www.dartlang.org/articles/json-web-service
	http://api.dartlang.org/docs/releases/latest/dart_html/HttpRequest.html

JSNI:
	https://developers.google.com/web-toolkit/doc/latest/DevGuideCodingBasicsJSNI

Calling Java methods from hand-written JavaScript:
    https://developers.google.com/web-toolkit/doc/latest/FAQ_Client#How_do_I_call_Java_methods_from_handwritten_JavaScript_or_third

Calling a Java Method from Handwritten JavaScript:
	https://developers.google.com/web-toolkit/doc/latest/DevGuideCodingBasicsJSNI#calling

Using postMessage in GWT:
	http://stackoverflow.com/questions/7269003/postmessage-from-external-script-to-gwt-parent

Using postMessage in Dart:
	http://blog.sethladd.com/2012/03/jsonp-with-dart.html

JavaScript Overlay Types:
	https://developers.google.com/web-toolkit/doc/latest/DevGuideCodingBasicsOverlay

Serving static files under App Engine:
	https://developers.google.com/appengine/docs/java/config/appconfig#Including_and_Excluding_Files

Using JavaScript from Dart: The js Library:
	http://www.dartlang.org/articles/js-dart-interop/

Video: Dart Intro Video
-----------------------