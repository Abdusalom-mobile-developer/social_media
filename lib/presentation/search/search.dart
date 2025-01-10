import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/presentation/home/widgets/bottom_nav_bar.dart';
import 'package:social_media/presentation/search/widgets/user_search_card.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.grey,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 1,
        onTap: (value) {
          if (value == 0) {
            context.go('/home_screen');
          } else if (value == 2) {
            context.go('/post_add');
          } else if (value == 3) {
            context.go('/favorite_screen');
          } else if (value == 4) {
            context.go('/profile_screen');
          }
        },
        items: [
          bottomNavigationBarItem(AppResponsive.widthM, Icons.home),
          bottomNavigationBarItem(
              AppResponsive.widthM, null, Ionicons.search_sharp),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_rounded,
              color: AppColors.black,
              size: AppResponsive.widthM * 0.11,
            ),
            activeIcon: Icon(
              Icons.add_circle_rounded,
              color: AppColors.brown,
              size: AppResponsive.widthM * 0.11,
            ),
            label: "",
          ),
          bottomNavigationBarItem(AppResponsive.widthM, Icons.favorite_rounded),
          bottomNavigationBarItem(
            AppResponsive.widthM,
            Icons.person_rounded,
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: FocusScope.of(context).unfocus,
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.width(0.033),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.black, width: 1.5),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: AppResponsive.height(0.03),
                ),
                Row(
                  spacing: AppResponsive.width(0.029),
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.only(left: AppResponsive.width(0.021)),
                        height: AppResponsive.height(0.063),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                                AppResponsive.width(0.03))),
                        child: TextField(
                          onSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            // String text = controller.text.trim();

                            setState(() {
                              isSearching = true;
                            });
                          },
                          controller: controller,
                          cursorColor: AppColors.black,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: AppResponsive.width(0.039),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                          ),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Enter username...",
                            hintStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: AppResponsive.width(0.039),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: AppResponsive.height(0.067),
                      width: AppResponsive.width(0.139),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        shape: BoxShape.circle,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          // String text = controller.text.trim();

                          setState(() {
                            isSearching = true;
                          });
                        },
                        child: Icon(
                          Icons.search,
                          color: AppColors.grey,
                          size: AppResponsive.width(0.07),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppResponsive.height(0.03),
                ),
                !isSearching
                    ? Expanded(
                        child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("posts")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.black,
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            return ListView(
                              children: [
                                StaggeredGrid.count(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: AppResponsive.height(0.013),
                                  crossAxisSpacing: AppResponsive.width(0.025),
                                  children: makePosts(snapshot.data!.docs),
                                ),
                              ],
                            );
                          }
                          return Text("Nothing found.");
                        },
                      ))
                    : Expanded(
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.black,
                                ));
                              } else if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs
                                      .where(
                                        (val) => val
                                            .data()["username"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                              controller.text
                                                  .trim()
                                                  .toLowerCase(),
                                            ),
                                      )
                                      .length,
                                  itemBuilder: (context, index) =>
                                      userSearchCard(snapshot.data!.docs
                                          .where(
                                            (val) => val
                                                .data()["username"]
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                  controller.text
                                                      .trim()
                                                      .toLowerCase(),
                                                ),
                                          )
                                          .toList()[index]
                                          .data()),
                                );
                              } else {
                                return Text("Nothing found");
                              }
                            }))
              ],
            )),
      ),
    );
  }

  List<Widget> makePosts(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList) {
    List<Widget> list = [];
    int count = 0;
    for (var data in dataList) {
      list.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: count % 7 == 0 ? 3 : 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppResponsive.width(0.03)),
            child: Image(
              image: NetworkImage(data.data()["image"]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
      count++;
    }

    list.add(
      SizedBox(
        height: AppResponsive.height(0.015),
      ),
    );
    return list;
  }
}
