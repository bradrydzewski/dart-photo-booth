import 'dart:html';

DivElement photos;
CanvasElement canvas;
CanvasRenderingContext2D ctx;
VideoElement video;

main() {
  // get the canvas element
  canvas = querySelector("#canvas");
  canvas.width=640;
  canvas.height=480;
  ctx = canvas.context2D;
  
  // get the video element
  video = querySelector("#video");
  video.autoplay=true;
  
  // initialize and set video.src to user media
  window.navigator
    .getUserMedia(audio: false, video: true)
    .then((stream) => video.src = Url.createObjectUrlFromStream(stream));

  // when I click the screen snap a photograph
  document.onClick.listen((_) {
    ctx.drawImage(video, 0, 0);
    
    // add the image to the film reel
    var img = new ImageElement();
    img.src = canvas.toDataUrl();
    querySelector("#photos").children.insert(0, img);
    
    
  });
  
  // TODO display "click here" on screen
  // TODO display countdown on screen
  // TODO publish file to remote server via http.post
}

void takePicture() {
  
}

void setCountdown() {

}

void clearCountdown() {
  
}

void sendPicture() {
  
}

void beep() {
  
}
