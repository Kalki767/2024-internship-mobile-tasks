import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'injection_container.dart' as di;
import 'features/product/presentation/pages/add_page.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/search_product.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
