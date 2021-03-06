import "dart:html";
import "dart:json" as json;
import 'package:js/js.dart' as js;

DivElement dartDiv;
EventStreamProvider<CustomEvent> customEventStreamProvider =
    new EventStreamProvider<CustomEvent>("CustomGwtEvent");

main() {
  // Say that the application has been loaded.
  dartDiv = query("#dartDiv");
  printString("Dart application loaded");
  
  // Request some JSON from the server. You can use the "dart:json" library
  // to parse it.
  HttpRequest.getString("/gwt_application/json_servlet").then((jsonStr) {
    printString("Here's the JSON I got: $jsonStr");
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
  
  // Setup a callback on window.dartApplicationModule.dartCallback.
  js.scoped(() {
    js.context.dartApplicationModule = js.map({
      "dartCallback": new js.Callback.many(dartCallback)
    });    
  });
    
  // Add a button to generate a CustomEvent called CustomDartEvent.
  var customEventButton = new ButtonElement()
    ..text = "Generate custom Dart event"
    ..classes.add("gwt-Button")  // For consistency
    ..onClick.listen((e) {
      var detail = {
        "n": 8,
        "s": "Hello from Dart",
        "obj": {
          "hello": "from Dart"          
        }
      };  
      var event = new CustomEvent("CustomDartEvent",
          canBubble: false, cancelable: false, detail: json.stringify(detail));
      window.dispatchEvent(event);
    });
  dartDiv.children.add(customEventButton);
  
  // Listen for CustomEvents called CustomGwtEvent.
  // In a week or two, we should be able to get rid of customEventStreamProvider
  // and just write: window.on['CustomGwtEvent'].listen(...).
  customEventStreamProvider.forTarget(window).listen((e) {
    var detail = json.parse(e.detail);
    printString("""
      Received a ${e.type} with
      n: ${detail["n"]},
      s: ${detail["s"]},
      obj.hello: ${detail["obj"]["hello"]}
    """);
  });
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