import 'package:cat_holder/models/cat.dart';
import 'package:cat_holder/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

/*
This StatefulWidget is responsible for displaying cat data and respond to user
interaction (add to user's favorite cat list)
*/

class CatCardWidget extends StatefulWidget {
  const CatCardWidget(
    this.cat, {
    Key? key,
  }) : super(key: key);
  final Cat? cat;

  @override
  State<CatCardWidget> createState() => _CatCardWidgetState();
}

class _CatCardWidgetState extends State<CatCardWidget> {
  @override
  Widget build(BuildContext context) {
    // Listens to change in the current user for display the right interface
    User currentUser = context.watch<User>();

    // Used to check if the user has this cat on his/hers favorite list
    bool addedToUserList = currentUser.likedCats.contains(widget.cat);

    // Displays shimmer effect to simulate network loading data
    return widget.cat == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
          )
        //
        // Main content section
        //
        : Container(
            margin: const EdgeInsets.all(8),
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                //
                // Leading cat picture
                //
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(widget.cat!.pictureUrl,
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      //  Cat name & description
                      //
                      Text(
                        widget.cat!.name,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(widget.cat!.description),
                      //
                      // Only shows the add / remove button if user is authenticated
                      //
                      currentUser.isAuthenticated()
                          ? //
                          // Custom add to / remove from favorites button section
                          //
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          // Changes color according to user's favorite list content
                                          colors: !addedToUserList
                                              ? <Color>[
                                                  Colors.orange[200]!,
                                                  Colors.orange,
                                                ]
                                              : <Color>[
                                                  Colors.white,
                                                  Colors.grey,
                                                ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    height: 35,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        // Changes color according to user's favorite list content
                                        primary: addedToUserList
                                            ? Colors.black
                                            : Colors.white,
                                        textStyle:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      onPressed: () {
                                        // Add or remove according to user's favorite list content
                                        addedToUserList
                                            ? currentUser.removeCat(widget.cat!)
                                            : currentUser.addCat(widget.cat!);
                                      },
                                      child: Center(
                                        child: Text(
                                            // Changes text according to user's favorite list content
                                            addedToUserList ? 'Remove' : 'Add'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
