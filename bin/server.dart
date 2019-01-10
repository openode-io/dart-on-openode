import 'dart:io' show Platform;
import 'dart:async' show runZoned;
import 'package:path/path.dart' show join, dirname;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

void main() {
  // Assumes the server lives in bin/ and that `webdev build` ran
  var pathToBuild = join(dirname(Platform.script.toFilePath()), '..');

  var handler = createStaticHandler(pathToBuild, defaultDocument: 'index.html');

  var port = 80;

  runZoned(() {
    io.serve(handler, '0.0.0.0', port);
    print("Serving $pathToBuild on port $port");
  }, onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
}
