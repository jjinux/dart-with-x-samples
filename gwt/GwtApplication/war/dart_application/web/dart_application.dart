import "dart:html";
import "dart:json" as JSON;

main() {
  // Say that the application has been loaded.
  var div = query("#dartDiv");
  div.appendHtml("<div>Dart application loaded</div>");
  
  // Request some JSON from the server. Of course, parsing it here is
  // overkill.
  var url = "/gwt_application/json_servlet";
  new HttpRequest.get(url, (req) {
    var json = JSON.parse(req.responseText);
    div.appendHtml("""
      <div>Here's the JSON I got: <span id="jsonData"></span></div>
    """);
    query("#jsonData").text = JSON.stringify(json);
  });
}