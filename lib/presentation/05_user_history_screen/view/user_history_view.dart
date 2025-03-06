import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../app/extensions.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/attendance_tile.dart';
import 'widgets/permission_tile.dart';

class UserHistoryView extends StatefulWidget {
  const UserHistoryView({Key? key}) : super(key: key);

  @override
  State<UserHistoryView> createState() => _UserHistoryViewState();
}

class _UserHistoryViewState extends State<UserHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedDay = _focusedDay;
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // Calendar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: _isDarkMode
                  ? ColorsManager.mediumBrown
                  : ColorsManager.creamyBeige,
              child: TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: _isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: _isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                  ),
                  titleTextStyle: Styles.style18Medium().copyWith(
                    color: _isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: _isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: (_isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown)
                        .withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(
                    color: _isDarkMode
                        ? ColorsManager.white
                        : ColorsManager.black,
                  ),
                  weekendTextStyle: TextStyle(
                    color: _isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                  ),
                  outsideTextStyle: TextStyle(
                    color: (_isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown)
                        .withOpacity(0.5),
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: _isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: TextStyle(
                    color: _isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          //  TabBar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _isDarkMode
                  ? ColorsManager.darkBrown.withOpacity(0.1)
                  : ColorsManager.sandYellow.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: _isDarkMode
                    ? ColorsManager.sandYellow
                    : ColorsManager.darkBrown,
                width: 2,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: _isDarkMode
                    ? ColorsManager.sandYellow
                    : ColorsManager.darkBrown,
              ),
              labelColor:
              _isDarkMode ? ColorsManager.darkBrown : ColorsManager.white,
              unselectedLabelColor: _isDarkMode
                  ? ColorsManager.sandYellow
                  : ColorsManager.darkBrown,
              labelStyle: Styles.style16Medium().copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: Styles.style16Medium(),
              padding: const EdgeInsets.all(3),
              tabs: [
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text('History'.tr()),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_late_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text('Permissions'.tr()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            color: _isDarkMode
                ? ColorsManager.sandYellow.withOpacity(0.3)
                : ColorsManager.darkBrown.withOpacity(0.3),
            thickness: 1,
            height: 1,
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHistoryTab(),
                _buildPermissionsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: 10, // Replace with actual history count
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AttendanceTile(
            date: DateTime.now().subtract(Duration(days: index)),
            checkIn: const TimeOfDay(hour: 9, minute: 0),
            checkOut: const TimeOfDay(hour: 17, minute: 0),
            totalHours: 8,
          ),
        );
      },
    );
  }

  Widget _buildPermissionsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Permission Types:'.tr(),
            style: Styles.style18Medium().copyWith(
              color: _isDarkMode
                  ? ColorsManager.sandYellow
                  : ColorsManager.darkBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: 4, // Number of permission types
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: PermissionTile(
                  date: DateTime.now().subtract(Duration(days: index)),
                  type: PermissionType.values[index % PermissionType.values.length],
                  onTap: () {
                    // TODO: Handle permission tile tap
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}