package org.dartlang.gwtapplication.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;

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
    Label gwtLoadedLabel = new Label();
    gwtLoadedLabel.setText("GWT application loaded");
    mainPanel.add(gwtLoadedLabel);
    
    // Add a button to call postMessage.
    Button postMessageButton = new Button("Post message from GWT");
    mainPanel.add(postMessageButton);
    postMessageButton.addClickHandler(new ClickHandler() {
      public void onClick(ClickEvent event) {
        postMessage("Hello from GWT!");
      }
    });
    
    listenForPostMessage();
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
    Label msgLabel = new Label();
    msgLabel.setText("GWT received a postMessage: Data: " +
        data + " Origin: " + origin);
    mainPanel.add(msgLabel);
  }
}
