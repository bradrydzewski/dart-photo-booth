library camera;
import 'dart:html';

abstract class Camera {
  /** start the video camera */
  start();
  
  /** pause the video camera */
  pause();
  
  /**
   * paused returns true if the camera's video
   * feed is paused.
   */
  paused();
  
  /**
   * capture a snapshot of the video feed and
   * return as a data URI.
   */
  String snapshot();
}

class Webcam extends Camera {
  final VideoElement video;
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  
  Webcam(this.video) {
    this.video.autoplay=true;

    // create a canvas an append to the body.
    // the canvas will be used to snapshot
    // an image frame from the webcam stream.
    this.canvas = new CanvasElement()
      ..width=640
      ..height=480
      ..hidden=true;
    this.ctx = canvas.context2D;
    document.body.append(canvas);

    window.navigator
      .getUserMedia(audio: false, video: true)
      .then((stream) => video.src = Url.createObjectUrlFromStream(stream));
  }

  start() => video.play();
  pause() => video.pause();
  paused() => video.paused;

  String snapshot() {
    ctx.drawImage(video, 0, 0);
    return canvas.toDataUrl();
  }
}