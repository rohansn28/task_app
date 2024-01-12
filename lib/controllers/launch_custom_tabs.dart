import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

void launchCustomTabURL(String link) async {
  try {
    await launch(
      link,
      customTabsOption: const CustomTabsOption(
        toolbarColor: Colors.teal,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        extraCustomTabs: <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
      safariVCOption: const SafariViewControllerOption(
        preferredBarTintColor: Colors.teal,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}
