// Project imports:
import 'package:flutter_social_demo/api/user_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/models/profile_model.dart';
import 'package:flutter_social_demo/repository/album_repository.dart';
import 'package:flutter_social_demo/models/album_model.dart';
import 'package:flutter_social_demo/models/post_model.dart';
import 'package:flutter_social_demo/models/user_model.dart';
import 'package:flutter_social_demo/repository/post_repository.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class ProfileRepository {
  final UserApi _userApi = UserApi();
  final String userId = SharedStorageService.getString(PreferenceKey.userId);

  Future<Profile> getUserProfile() async {
    try {
      Profile? profileData;
      bool needToFetch = true;
      // check caching time
      if (!CachingService.needToSendRequest(
          key: PreferenceKey.profileCacheTime)) {
        // check if Hive is not empty
        profileData =
            await CachingService.getCachedProfile(userId: int.parse(userId));
        needToFetch = profileData == null;
      }

      if (needToFetch) {
        // get user data
        final User? userData = await _userApi.getById(id: userId);
        if (userData == null) {
          throw NotFoundException;
        } else {
          profileData = Profile(user: userData, posts: [], albums: []);

          // to receive data we will use other repositories
          List<Post> posts = await PostRepository().getPostsList();
          List<Album> albums = await AlbumRepository().getAlbumsList();

          final int postsMax = (posts.length > 3) ? 3 : posts.length;
          final int albumsMax = (albums.length > 3) ? 3 : posts.length;

          // add only first three elements to profile object
          if (posts.isNotEmpty) {
            for (int i = 0; i < postsMax; i++) {
              profileData.posts!.add(posts[i]);
            }
          }

          if (albums.isNotEmpty) {
            for (int i = 0; i < albumsMax; i++) {
              profileData.albums!.add(albums[i]);
            }
          }
        }

        // cache time and users list
        CachingService.cacheProfile(data: profileData);
        CachingService.setCachingTime(
            key: PreferenceKey.profileCacheTime, time: DateTime.now());
      }
      return profileData!;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
