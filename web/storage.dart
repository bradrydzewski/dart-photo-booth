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
    data["id"] = time;
    
    // TODO: find time to handle exceptions and avoid
    // havint to use try / catch blocks.
    try {
      // create and post a unique identifier for the image
      // based on the timestamp.
      var postKeyRequest = new HttpRequest();
      postKeyRequest
        ..open("POST", "https://flickering-fire-7106.firebaseio.com/images.json", async: false)
        ..send(JSON.encode(data));
  
      // then post the image with the key equal to the timestamp.
      // this allows us to retrieve a list of all images without
      // having to retrieve the image data.
      //data = new Map();
      //data["image"] = img;
      var postBlobRequest = new HttpRequest();
      postBlobRequest
        ..open("PUT", "https://flickering-fire-7106.firebaseio.com/blobs/${time}.json", async: false)
        ..send(JSON.encode(img));
      
    }catch(e){
      print(e);
    }
  }
}