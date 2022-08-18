import 'package:cat_holder/models/user.dart';
import 'package:cat_holder/services/database.dart';
import 'package:cat_holder/views/cat_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Listen for changes (provider) in the current user
    User currentUser = context.watch<User>();

    //
    // Main content
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        // Profile header
        //
        profileHeader(currentUser),
        const SizedBox(height: 12),

        //
        // My cats section
        //
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cats",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        // Checks if user is authenticated to display the data
        currentUser.isAuthenticated()
            ? Expanded(
                child: currentUser.likedCats.isNotEmpty
                    ? ListView.builder(
                        itemCount: currentUser.likedCats.length,
                        itemBuilder: ((context, index) {
                          return CatCardWidget(currentUser.likedCats[index]);
                        }),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "You didn't add any kittens yet. Go to the other page and add some 🐱",
                        ),
                      ),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text("Sorry, no profile, no cats for you 🐱"),
                    TextButton(
                        onPressed: () {
                          currentUser.name = "Catholder-22";
                          currentUser.birthday = DateTime(1999);
                          currentUser.pictureUrl =
                              "https://is2-ssl.mzstatic.com/image/thumb/Purple128/v4/82/e5/4a/82e54a68-c8fb-0ac4-70af-7bb282944ec3/source/256x256bb.jpg";
                          currentUser.authenticate(context
                              .read<CatHolderDatabase>()
                              .logIn(currentUser));
                        },
                        child: const Text("Try to login again..."))
                  ],
                ),
              ),
      ],
    );
  }

  // Profile header widget
  Widget profileHeader(User loggedInUser) {
    // Checks if user is authenticated to display the data
    return loggedInUser.isAuthenticated()
        ? Container(
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loggedInUser.name!,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                          '${((loggedInUser.birthday!.difference(DateTime.now()).inDays) / 365).floor().abs().toString()} years'),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(loggedInUser.pictureUrl!),
                  ),
                ),
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("Sorry, we had some problems loading your profile 🐱"),
          );
  }
}
