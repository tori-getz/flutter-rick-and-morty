abstract class AbstractException implements Exception {
  final String? message;
  AbstractException(this.message);
}

class ServerException extends AbstractException {
  ServerException([super.message]);
}

class CacheException extends AbstractException {
  CacheException([super.message]);
}
