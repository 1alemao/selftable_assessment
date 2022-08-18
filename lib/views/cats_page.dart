import 'package:cat_holder/services/database.dart';
import 'package:cat_holder/views/cat_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatsPage extends StatelessWidget {
  const CatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // Feature cats section
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Featured",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Column(
              children: context
                  .read<CatHolderDatabase>()
                  .featuredCats
                  .map((e) => CatCardWidget(e))
                  .toList(),
            ),
            //
            // All cats section
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("All cats",
                  style: Theme.of(context).textTheme.headline1),
            ),
            Column(
              children: context
                  .read<CatHolderDatabase>()
                  .allCats
                  .map((e) => CatCardWidget(e))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
