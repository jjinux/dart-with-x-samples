import "dart:html";
import 'package:js/js.dart' as js;

DivElement dartDiv;

main() {
  // Say that the application has been loaded.
  dartDiv = query("#dartDiv");
  printString("Dart application loaded");
  
  // Request some JSON from the server. You can use the "dart:json" library
  // to parse it.
  HttpRequest.getString("/gwt_application/json_servlet").then((json) {
    printString("Here's the JSON I got: $json");
  }).catchError((e) {
    printString("Couldn't fetch JSON: ${e.error}");
  });

  // Add a button to call postMessage.
  var postMessageButton = new ButtonElement()
    ..text = "Post message from Dart"
    ..classes.add("gwt-Button")  // For consistency
    ..onClick.listen((e) => window.postMessage("Hello from Dart!", "*"));
  dartDiv.children.add(postMessageButton);
  
  // Receive postMessage events.
  window.onMessage.listen((e) {
    printString("""
      Dart received a postMessage:
      Data: ${e.data},
      Origin: ${e.origin}
    """);
  });
  
  // Setup a callback on window.dartApplicationModule.dartCallback.
  js.scoped(() {
    js.context.dartApplicationModule = js.map({
      "dartCallback": new js.Callback.many(dartCallback)
    });    
  });
  
  // Add a button to call gwtApplicationModule.gwtCallback.
  var callGwtCallback = new ButtonElement()
    ..text = "Call GWT callback from Dart"
    ..classes.add("gwt-Button")  // For consistency
    ..onClick.listen((e) {
      js.scoped(() {
        var result = js.context.gwtApplicationModule.gwtCallback(
            8, "Hello from Dart", js.map({'hello': 'from Dart'}));
        printString(result);
      });
    });
  dartDiv.children.add(callGwtCallback);
}

void printString(String s) {
  var div = new DivElement()
    ..text = s;
  dartDiv.children.add(div);
}

String dartCallback(int n, String s, js.Proxy obj) {
  printString("""
    Dart callback called with
    n: $n,
    s: $s,
    obj.hello: ${obj.hello}
  """);
  return "Dart received the callback";
}