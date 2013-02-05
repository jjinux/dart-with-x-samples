import "dart:html";
import "dart:json" as JSON;

main() {
  // Say that the application has been loaded.
  var div = query("#dartDiv");
  div.appendHtml("<div>Dart application loaded</div>");
  
  // Request some JSON from the server. Of course, parsing it here is
  // silly, but I'm showing it for completeness.
  var url = "/gwt_application/json_servlet";
  new HttpRequest.get(url, (req) {
    var json = JSON.parse(req.responseText);
    var escaped = htmlEscape(JSON.stringify(json));
    div.appendHtml("<div>Here's the JSON I got: $escaped</div>");
  });

  // Add a button to call postMessage.
  var postMessageButton = new ButtonElement()
    ..id = "postMessage"
    ..text = "Post message from Dart"
    ..classes.add("gwt-Button")  // For consistency
    ..onClick.listen((e) => window.postMessage("Hello from Dart!", "*"));
  div.children.add(postMessageButton);
  
  // Receive postMessage events.
  window.onMessage.listen((e) {
    div.appendHtml("<div>Dart received postMessage: "
                   "Data: ${htmlEscape(e.data)} "
                   "Origin: ${htmlEscape(e.origin)}</div>");
  });
}
        
String htmlEscape(String text) {
  return text.replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&apos;");
}