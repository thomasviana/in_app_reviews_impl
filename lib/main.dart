import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

void main() => runApp(const InAppReviewExampleApp());

enum Availability { loading, available, unavailable }

class InAppReviewExampleApp extends StatefulWidget {
  const InAppReviewExampleApp({Key? key}) : super(key: key);

  @override
  _InAppReviewExampleAppState createState() => _InAppReviewExampleAppState();
}

class _InAppReviewExampleAppState extends State<InAppReviewExampleApp> {
  final InAppReview _inAppReview = InAppReview.instance;

  String _appStoreId = '';
  String _microsoftStoreId = '';
  Availability _availability = Availability.loading;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability =
              isAvailable ? Availability.available : Availability.unavailable;
        });
      } catch (e) {
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

  void _setAppStoreId(String id) => _appStoreId = id;

  void _setMicrosoftStoreId(String id) => _microsoftStoreId = id;

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  @override
  Widget build(BuildContext context) {
    final status = describeEnum(_availability);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('In App Review Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('In App Review status: $status'),
                const SizedBox(height: 10),
                // TextField(
                //   onChanged: _setAppStoreId,
                //   decoration: const InputDecoration(hintText: 'App Store ID'),
                // ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 35)),
                  onPressed: _requestReview,
                  child: const Text('Request Review'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 35)),
                  onPressed: _openStoreListing,
                  child: const Text('Open Store Listing'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';

// import './rating_service.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   final RatingService _ratingService = RatingService();

//   @override
//   initState() {
//     super.initState();

//     Timer(const Duration(seconds: 2), () {
//       _ratingService.showRating();
//       // _ratingService.isSecondTimeOpen().then((secondOpen) {
//       //   if (secondOpen) {
//       //     _ratingService.showRating();
//       //   }
//       // });
//     });
//   }

//   Future<void> _incrementCounter(context) async {
//     setState(() {
//       _counter++;
//     });
//     /**
//      * In demand rating flow
//      */
//     if (_counter == 5) {
//       _ratingService.showRating();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _incrementCounter(context),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
