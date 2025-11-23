import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:vital_core/core.dart' as vital_core;

class VitalInterceptor implements Interceptor {
  final String? apiKey;
  final bool useAccessToken;

  VitalInterceptor(this.useAccessToken, this.apiKey) {
    if (useAccessToken && apiKey != null) {
      throw Exception("useAccessToken is true, but an API key is provided.");
    }

    if (!useAccessToken && apiKey == null) {
      throw Exception(
          "useAccessToken is false, but an API key is not provided.");
    }
  }

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final headers = useAccessToken
        ? await vital_core.getVitalAPIHeaders()
        : {
            "X-Vital-API-Key": apiKey!,
            "X-Vital-SDK-Note": "flutter,apikey"
          };

    final updatedRequest = applyHeaders(chain.request, headers);
    return chain.proceed(updatedRequest);
  }
}
