// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:hungryhub/controlls/product_model.dart';
// import 'package:provider/provider.dart';

// class SearchItem extends StatefulWidget {
//   const SearchItem({super.key});

//   @override
//   State<SearchItem> createState() => _SearchItemState();
// }

// class _SearchItemState extends State<SearchItem> {
//   @override
//   Widget build(BuildContext context) {

//     provider.allSearchResult;
//     return Scaffold(
//       body: SizedBox(
//         height: 100,
//         width: 200,
//         child: ListView.builder(
//           itemCount: provider.allSearchResult.length,
//           itemBuilder: (context, index) {
//             final data = provider.allSearchResult[index];
//             return ListTile(
//               title: Text(data.productName),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
