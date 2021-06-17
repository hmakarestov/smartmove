import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'constraints.dart';
import 'components/help_app_bar.dart';
import 'datamodels/help_tab.dart';
import 'utils/icons_helper.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    final String lorem =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae eros odio. Duis lorem enim, mollis vitae commodo eget, posuere et odio. Praesent malesuada interdum augue in ultrices. Aenean vitae scelerisque purus. Nam sodales interdum sapien id ultricies. Suspendisse potenti. Quisque a suscipit metus. Ut semper lorem sit amet scelerisque imperdiet. Curabitur vel metus eu mi porta faucibus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae eros odio. Duis lorem enim, mollis vitae commodo eget, posuere et odio. Praesent malesuada interdum augue in ultrices. Aenean vitae scelerisque purus. Nam sodales interdum sapien id ultricies. Suspendisse potenti. Quisque a suscipit metus. Ut semper lorem sit amet scelerisque imperdiet. Curabitur vel metus eu mi porta faucibus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae eros odio. Duis lorem enim, mollis vitae commodo eget, posuere et odio. Praesent malesuada interdum augue in ultrices. Aenean vitae scelerisque purus. Nam sodales interdum sapien id ultricies. Suspendisse potenti. Quisque a suscipit metus. Ut semper lorem sit amet scelerisque imperdiet. Curabitur vel metus eu mi porta faucibus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae eros odio. Duis lorem enim, mollis vitae commodo eget, posuere et odio. Praesent malesuada interdum augue in ultrices. Aenean vitae scelerisque purus. Nam sodales interdum sapien id ultricies. Suspendisse potenti. Quisque a suscipit metus. Ut semper lorem sit amet scelerisque imperdiet. Curabitur vel metus eu mi porta faucibus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae eros odio. Duis lorem enim, mollis vitae commodo eget, posuere et odio. Praesent malesuada interdum augue in ultrices. Aenean vitae scelerisque purus. Nam sodales interdum sapien id ultricies. Suspendisse potenti. Quisque a suscipit metus. Ut semper lorem sit amet scelerisque imperdiet. Curabitur vel metus eu mi porta faucibus.";
    List<HelpTab> tabs = [];
    tabs.add(new HelpTab(title: "About SmartMove", text: lorem, icon: "info"));
    tabs.add(new HelpTab(title: "FAQ", text: lorem, icon: "faq"));
    tabs.add(new HelpTab(title: "Other locations", text: lorem, icon: "location"));

    return Scaffold(
      appBar: HelpAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            return ExpandableNotifier(
              child: ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: true,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(134),
                          color: kBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset:
                                  Offset(1, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        width: screenSize().width - 40,
                        height: 80.0 * 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: Icon(
                                IconsHelper.getIconByName(tabs[index].icon),
                                size: 120.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              tabs[index].title,
                              style: TextStyle(
                                fontSize: 34.0 * 2,
                                fontWeight: FontWeight.bold,
                                color: kMainOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Text(
                      tabs[index].text,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 24.0 * 2,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 40),
        ),
      ),
    );
  }
}
