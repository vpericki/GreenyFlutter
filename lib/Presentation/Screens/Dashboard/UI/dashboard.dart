import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/Presentation/Screens/Achievements/widgets/build_card.dart';
import 'package:greeny_flutter_app/business_logic/secure_storage.dart';
import 'package:greeny_flutter_app/models/user_with_achievements.dart';

import '../../../../business_logic/bloc/Dashboard/dashboard_bloc.dart';
import '../../../../models/achievement.dart';
import '../../../../models/user.dart';
import '../../../Components/spacers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardBloc _dashboardBloc = DashboardBloc();

  @override
  void initState() {
    _dashboardBloc.add(LoadUserInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              secureStorage.deleteAll();
              Navigator.pushReplacementNamed(context, "/");
            },
            child: const Icon(Icons.logout)),
        body: initialLayout());
  }

  Widget initialLayout() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocProvider(
              create: (_) => _dashboardBloc,
              child: BlocListener<DashboardBloc, DashboardState>(
                listener: (context, state) {
                  if (state is DashboardError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message!),
                      ),
                    );
                  }
                },
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardInitial) {
                      return _buildLoading();
                    } else if (state is DashboardLoading) {
                      return _buildLoading();
                    } else if (state is DashboardLoaded) {
                      return _buildView(context, state.user);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildView(BuildContext context, UserAchievements user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Welcome ${user.name}",
              style: const TextStyle(fontSize: 24),
            ),
            const HeightSpacer(myHeight: 10.00),
            Text("Your points: ${user.points}"),
            const HeightSpacer(myHeight: 30.00),
            SizedBox(
                height: 400, child: _buildList(context, user.achievements!)),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Achievement> achievements) {
    return AchievementBuilder().buildCard(context, achievements);
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
