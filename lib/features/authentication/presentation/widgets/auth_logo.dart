import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants/image_path.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePath.authLogo,
      width: 64.w,
      height: 64.w,
      fit: BoxFit.contain,
    );
  }
}
