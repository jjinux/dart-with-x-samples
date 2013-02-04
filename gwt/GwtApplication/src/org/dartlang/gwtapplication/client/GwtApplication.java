package org.dartlang.gwtapplication.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;

/**
 * Entry point classes define <code>onModuleLoad()</code>.
 */
public class GwtApplication implements EntryPoint {

  /**
   * This is the entry point method.
   */
  public void onModuleLoad() {
    VerticalPanel mainPanel = new VerticalPanel();
    RootPanel.get("gwtDiv").add(mainPanel);
    
    Label gwtLoadedLabel = new Label();
    gwtLoadedLabel.setText("GWT application loaded");
    mainPanel.add(gwtLoadedLabel);
  }
}
