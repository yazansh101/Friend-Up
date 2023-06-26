import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/view_models/activity_feed/activity_feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/time_helper.dart';
import '../../../core/widgets/custom_text.dart';
import '../widgets/activity_item.dart';

class ActivityFeedScreen extends StatelessWidget {
  const ActivityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Consumer<ActivityFeedViewModel> _buildBody() {
    return Consumer<ActivityFeedViewModel>(
      builder: (context, activityFeedViewModel, child) => StreamBuilder(
        stream: activityFeedViewModel.getMyActivityFeeds(),
        builder: (context, activityFeedSnapshot) {
          if (activityFeedSnapshot.hasData) {
            List activityItems = activityFeedSnapshot.data!.docs;
            return _buildListOfActivityFeeds(
                activityItems, activityFeedViewModel,);
          } else {
            return const Center(
                child: CustomText(
              text: 'no activity feeds',
              color: Colors.white,
            ));
          }
        },
      ),
    );
  }

  ListView _buildListOfActivityFeeds(List<dynamic> activityItems,
      ActivityFeedViewModel activityFeedViewModel) {
    return ListView.builder(
      itemCount: activityItems.length,
      itemBuilder: (ctx, index) {
        return 
        
         AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                decoration: const BoxDecoration(),
                child: ActivityItem(
                  imageUrl: activityItems[index]['userProfileImage'],
                  userId: activityItems[index]['userId'],
                  userName:activityItems[index]['userName'] ,
                  time: TimeHelper.getLastSeen(activityItems[index]['timesmap']),
                  activityType: activityFeedViewModel.getActivityStatement(activityItems[index]['activityType']),
                ),
              ),
            ),
          ),
        );

      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: CustomText(
          text: 'Activity Feed',
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

