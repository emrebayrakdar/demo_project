import 'package:flutter/material.dart';

extension FutureExtension on Future {
  Widget toBuild<T>({
    required Widget Function(T? data) onSuccess,
    required Widget loadingWidget,
    required Widget notFoundWidget,
    required Widget Function(String data) onError,
    dynamic data,
  }) {
    return FutureBuilder<T>(
      future: this as Future<T>?,
      initialData: data,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return loadingWidget;
          case ConnectionState.done:
            if (snapshot.hasData) return onSuccess(snapshot.data);
            var tmpError = snapshot.error.toString();
            if (tmpError.isEmpty) tmpError = "Liste alınırken beklenmeyen bir sorun oluştu. Lütfen tekrar deneyiniz!";
            return onError(tmpError);
          default:
            return notFoundWidget;
        }
      },
    );
  }
}
