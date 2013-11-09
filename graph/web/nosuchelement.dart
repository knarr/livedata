
class NoSuchElementException implements Exception {
  factory NoSuchElementException(String message){
    print("Invalid Element Error!  " + message);
  }
}