// List<Map<String, String>> todos = [
//   {
//     "title": "task1",
//     "description": "description1",
//     "date": "19-06-2012",
//   },
//   {
//     "title": "task2",
//     "description":
//         "alkndalskdnlkandlkasnclknlkanclksanclkasnalkfnwlknalkdnalwkfnc awlvk alknvaklwcnawlkcnawlkcnalkcnawlkcnalk naklwdn alwkdn wlakdnawlk nwqlkd nwalkdn walkdn walawnd lkawndlkawnd awlkdn lakdnlawknd awlkn lwakdn lawkdn awlkdn lawknd wlkadnalkw dnlawkdn lwand lwak",
//     "date": "19-06-2012",
//   },
//   {
//     "title": "task3",
//     "description": "description3",
//     "date": "19-06-2012",
//   },
// ];

import 'package:flutter_riverpod/flutter_riverpod.dart';

// List todos = [];

final todos_riverpod = Provider<List>((ref) => []);
