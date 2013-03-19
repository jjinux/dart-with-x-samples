package {
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;

  public class Document extends Sprite {

    function Document():void {
      if (stage) {
        init();
      } else {
        addEventListener(Event.ADDED_TO_STAGE, init);
      }
    }

    private function init(event:Event = null):void {
      trace("Initialize here.");
      button.buttonModue = true;
      button.useHandCursor = true;
      button.addEventListener(MouseEvent.CLICK, onButtonClick);
    }

    private function onButtonClick(event:Event):void {
      textField.text = "Hello World!";
    }
  }
}
