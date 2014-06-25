library storage;
import 'dart:html';
import 'dart:convert';

abstract class Store {
  /**
   * Sends the image (data URI) to the 
   * underlying storage system
   */
  void send(String img);
}

class RemoteStorage extends Store {

  RemoteStorage();

  /**
   * Sends the image (data URI) to the 
   * remote storage system
   */
  void send(String img){
    
    var time = new DateTime.now().millisecondsSinceEpoch;
    var data = new Map();
    data["time"] = time;
    data["image"] = img;
    
    // TODO: find time to handle exceptions and avoid
    // havint to use try / catch blocks.
    try {
      // create and post a unique identifier for the image
      // based on the timestamp.
      var postKeyRequest = new HttpRequest();
      postKeyRequest
        ..open("POST", "https://flickering-fire-7106.firebaseio.com/images.json")
        ..send(JSON.encode(data));
      
    }catch(e){
      print(e);
    }
  }
}