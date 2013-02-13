package org.dartlang.gwtapplication.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;

import elemental.client.Browser;
import elemental.dom.Document;
import elemental.events.CustomEvent;
import elemental.events.Event;
import elemental.events.EventListener;
import elemental.html.Window;
import elemental.js.json.JsJsonNumber;
import elemental.js.json.JsJsonObject;
import elemental.json.Json;
import elemental.json.JsonObject;

/**
 * Entry point classes define <code>onModuleLoad()</code>.
 */
public class GwtApplication implements EntryPoint {

  private VerticalPanel mainPanel = new VerticalPanel();

  /**
   * This is the entry point method.
   */
  public void onModuleLoad() {
    RootPanel.get("gwtDiv").add(mainPanel);
    
    // Say that the application has been loaded.
    printString("GWT application loaded");
    
    // Add a button to call postMessage.
    Button postMessageButton = new Button("Post message from GWT");
    mainPanel.add(postMessageButton);
    postMessageButton.addClickHandler(new ClickHandler() {
      public void onClick(ClickEvent event) {
        postMessage("Hello from GWT!");
      }
    });
    
    listenForPostMessage();
    
    // Add a button to call dartApplicationModule.dartCallback.
    Button callDartCallback = new Button("Call Dart callback from GWT");
    mainPanel.add(callDartCallback);
    callDartCallback.addClickHandler(new ClickHandler() {
      public void onClick(ClickEvent event) {
        String result = callDartCallback(
            7, "Hello from GWT", createObjectForCallback());
        printString(result);
      }
    });
    
    initGwtApplicationModule();

    // Add a button to generate a CustomEvent called CustomGwtEvent.
    final Document document = Browser.getDocument();
    final Window window = Browser.getWindow();
    Button generateCustomGwtEvent = new Button("Generate custom GWT event");
    mainPanel.add(generateCustomGwtEvent);
    generateCustomGwtEvent.addClickHandler(new ClickHandler() {
      public void onClick(ClickEvent event) {
        CustomEvent customEvent = (CustomEvent) document.createEvent("CustomEvent");
        JsonObject detail = JsJsonObject.create();
        detail.put("n", JsJsonNumber.create(7));
        detail.put("s", "Hello from GWT");
        JsonObject obj = JsJsonObject.create();
        obj.put("hello", "from GWT");
        detail.put("obj", obj);
        customEvent.initCustomEvent("CustomGwtEvent", false, false, detail.toJson());
        window.dispatchEvent(customEvent);
      }
    });

    // Listen for CustomEvent called CustomDartEvent.
    window.addEventListener("CustomDartEvent", new EventListener() {
      public void handleEvent(Event evt) {
        CustomEvent customEvent = (CustomEvent) evt;
        JsonObject detail = Json.parse((String) customEvent.getDetail());
        JsonObject obj = detail.get("obj");
        printString("Received a " + customEvent.getType() + " with " +
            "n: " + detail.get("n") + ", " +
            "s: " + detail.get("s") + ", " +
            "obj.hello: " + obj.get("hello"));
      }
    }, false);
  }
  
  private void printString(String s) {
    Label label = new Label();
    label.setText(s);
    mainPanel.add(label);
  }
  
  protected native void postMessage(String msg) /*-{
    $wnd.postMessage(msg, "*");
  }-*/;

  private final native void listenForPostMessage() /*-{
    var that = this;
    $wnd.addEventListener("message", function(msg) {
      that.@org.dartlang.gwtapplication.client.GwtApplication::onPostMessage(Ljava/lang/String;Ljava/lang/String;)(
          msg.data, msg.origin);
    });
  }-*/;
  
  private void onPostMessage(String data, String origin) {
    printString("GWT received a postMessage: Data: " +
        data + ", Origin: " + origin);
  }
  
  private final native String callDartCallback(int n, String s,
      JavaScriptObject obj) /*-{
    return $wnd.dartApplicationModule.dartCallback(n, s, obj);    
  }-*/;  
      
  private final native JavaScriptObject createObjectForCallback() /*-{
    return {"hello": "from GWT"};
  }-*/;

  private final native void initGwtApplicationModule() /*-{
    var that = this;
    $wnd.gwtApplicationModule = {
      gwtCallback: function(n, s, obj) {
        return that.@org.dartlang.gwtapplication.client.GwtApplication::gwtCallback(ILjava/lang/String;Lorg/dartlang/gwtapplication/client/JavaScriptObjectPassedFromDart;)(
          n, s, obj);
      }
    };
  }-*/;
  
  private String gwtCallback(int n, String s, JavaScriptObjectPassedFromDart obj) {
    printString("GWT callback called with " +
        "n: " + n + ", " +
        "s: " + s + ", " +
        "obj.hello: " + obj.hello());
    return "GWT received the callback";
  }
}

/** This is a JavaScript overlay type. */
class JavaScriptObjectPassedFromDart extends JavaScriptObject {

  protected JavaScriptObjectPassedFromDart() {}

  public final native String hello() /*-{ return this.hello; }-*/;
}