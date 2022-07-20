import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_social_demo/resources/resources.dart';

void main() {
  test('app_icons assets test', () {
    expect(File(AppIcons.gallery).existsSync(), true);
    expect(File(AppIcons.posts).existsSync(), true);
    expect(File(AppIcons.profile).existsSync(), true);
    expect(File(AppIcons.usersList).existsSync(), true);
  });
}
