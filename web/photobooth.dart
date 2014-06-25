import 'dart:html';
import 'dart:async';
import 'storage.dart';
import 'camera.dart';

main() {
  document.body.requestFullscreen();
  
  var camera = new Webcam(querySelector("#video"));
  var storage = new RemoteStorage();
  new PhotoBooth(camera,storage);
}

class PhotoBooth {
  DivElement _photos;
  DivElement _counter;
  ButtonElement _button;
  
  final Store storage;
  final Camera camera;
  
  PhotoBooth(this.camera, this.storage) {
    _photos  = querySelector("#photos");
    _counter = querySelector("#countdown");
    _button = querySelector("#button");
    
    document.onClick.listen((_){
      // exit if camera is paused, which would indicate
      // a photo shoot is already in progress.
      if (camera.paused()) return;

      // display the countdown clock and
      // hiden the "click here" button.
      setCount(3);
      _counter.classes.toggle("hidden");
      _button.classes.toggle("hidden");
      
      // start the countdown 
      sleep(1)
        .then((_) => setCount(2))
        .then((_) => sleep(1))
        .then((_) => setCount(1))
        .then((_) => sleep(1))
        .then((_) => onBeforePhoto())
        .then((_) => onPhoto())
        .then((_) => sleep(2))
        .then((_) => onAfterPhoto());
    });
  }

  // sets the countdown value to N, signaling
  // to the patron the photograph is scheduled
  // in N seconds.
  setCount(int n) => _counter.text = "${n}";

  // performs necessary operations prior to
  // snapping the photograph, such as hiding
  // our countdown clock and pausing the camera's
  // video feed.
  void onBeforePhoto() {
    _counter.classes.toggle("hidden");
    camera.pause();
  }

  void onAfterPhoto() {
    camera.start();
    _button.classes.toggle("hidden");
  }
  
  void onPhoto() {
    var uri = camera.snapshot();
    addPhoto(uri);
    storage.send(uri);
  }
  
  // append the image to the picture reel.
  void addPhoto(String uri) {
    var img = new ImageElement()
      ..src = uri;
    _photos.children.insert(0, img);
  }

  // returns a Future that sleep for N seconds
  // to complete, used when chaining together
  // tasks with an artifical pause.
  Future sleep(int n) => new Future.delayed(new Duration(seconds: n));
}
