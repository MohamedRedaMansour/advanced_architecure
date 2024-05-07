/// Wraps the type of http requests allowed with it's associated string value
///
enum RequestType {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE'),
  upload('UPLOAD'),
  patch('PATCH'),
  download('DOWNLOAD');

  final String method;
  const RequestType(this.method);
}
