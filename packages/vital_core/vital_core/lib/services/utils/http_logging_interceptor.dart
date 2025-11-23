import 'package:chopper/chopper.dart';

class HttpRequestLoggingInterceptor extends HttpLoggingInterceptor {
  HttpRequestLoggingInterceptor({
    Level level = Level.body,
    bool onlyErrors = false,
  }) : super(level: level, onlyErrors: onlyErrors);
}
