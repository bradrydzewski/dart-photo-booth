library storage;

abstract class Store {
  /**
   * Sends the image (data URI) to the 
   * underlying storage system
   */
  void send(String img);
}

class RemoteStorage extends Store {
  String uri = "https://path/to/upload";
  
  RemoteStorage(this.uri);
  
  /**
   * Sends the image (data URI) to the 
   * remote storage system
   */
  void send(String img){
    
  }
}