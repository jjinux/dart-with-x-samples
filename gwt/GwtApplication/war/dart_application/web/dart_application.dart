import "dart:html";
import "dart:json" as JSON;
import 'package:js/js.dart' as js;

DivElement dartDiv;

main() {
  // Say that the application has been loaded.
  dartDiv = query("#dartDiv");
  dartDiv.appendHtml("<div>Dart application loaded</div>");
  
  // Request some JSON from the server. Of course, parsing it here is
  // silly, but I'm showing it for completeness.
  var url = "/gwt_application/json_servlet";
  new HttpRequest.get(url, (req) {
    var json = JSON.parse(req.responseText);
    var escaped = htmlEscape(JSON.stringify(json));
    dartDiv.appendHtml("<div>Here's the JSON I got: $escaped</div>");
  });

  // Add a button to call postMessage.
  var postMessageButton = new ButtonElement()
    ..id = "postMessage"
    ..text = "Post message from Dart"
    ..classes.add("gwt-Button")  // For consistency
    ..onClick.listen((e) => window.postMessage("Hello from Dart!", "*"));
  dartDiv.children.add(postMessageButton);
  
  // Receive postMessage events.
  window.onMessage.listen((e) {
    dartDiv.appendHtml("""
      <div>
        Dart received a postMessage:
        Data: ${htmlEscape(e.data)},
        Origin: ${htmlEscape(e.origin)}
      </div>
    """);
  });
  
  // Setup a callback on window.dartApplicationModule.dartCallback.
  js.scoped(() {
    js.context.dartApplicationModule = js.map({
      "dartCallback": new js.Callback.many(dartCallback)
    });    
  });
}

String dartCallback(int n, String s, js.Proxy obj) {
  dartDiv.appendHtml("""
    <div>
      Callback called with
      n: ${htmlEscape(n.toString())},
      s: ${htmlEscape(s)},
      obj.hello: ${htmlEscape(obj.hello)}
    </div>
  """);
  return "Dart received the callback";
}
        
String htmlEscape(String text) {
  return text.replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&apos;");
}