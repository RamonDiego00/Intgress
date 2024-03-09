import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:intgress/screens/AnnotationPage.dart';

import '../screens/FillNotePage.dart';

final router = FluroRouter();

void defineRoutes() {
  router.define(
    '/annotation',
    handler: Handler(
      handlerFunc: (context, _) =>  AnnotationPage(),
    ),
  );

  router.define(
    '/fillNote',
    handler: Handler(
      handlerFunc: (context, _) => const FillNotePage(),
    ),
  );
}