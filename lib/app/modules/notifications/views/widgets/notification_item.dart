import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        title: Text(
          'Your order #4521 has been shipped\nExpected delivery: Apr 24, 2025',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Text(
            'Apr 21, 2025 at 03:45 PM',
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
          ),
        ),
        leading: Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              Constants.notificationsIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
