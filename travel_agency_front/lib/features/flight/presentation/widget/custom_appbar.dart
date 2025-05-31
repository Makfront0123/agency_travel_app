import 'package:flutter/material.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.showUser = true,
    this.title,
  });
  final bool showUser;

  final String? title;

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(color: AppColors.lightTextColor),
            )
          : null,
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      leading: showUser
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              color: AppColors.lightTextColor,
            )
          : const SizedBox.shrink(),
    );
  }
}
