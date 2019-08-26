// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter_web_ui/ui.dart' as ui;
import 'package:uur_flutter_website/main.dart' as app;
import 'package:firebase/firebase.dart';


main() async {

  App fireApp = initializeApp(
      apiKey: "AIzaSyDYUeWo3Ry60oZDTLBCVVjo1laZpK4r0x0",
      authDomain: "uur-website.firebaseapp.com",
      databaseURL: "https://uur-website.firebaseio.com",
      projectId: "uur-website",
      storageBucket: "",
      messagingSenderId: "308322994523",
  );

  print(fireApp.jsObject.name);

  await ui.webOnlyInitializePlatform();
  app.main();
}
