import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/spotify_information_entity.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spotify_sdk/spotify_sdk.dart';


class ChooseSpotifySong extends StatefulWidget {
  const ChooseSpotifySong({super.key});

  @override
  State<ChooseSpotifySong> createState() => _ChooseSpotifySongState();
}

class _ChooseSpotifySongState extends State<ChooseSpotifySong> {
  Dio dio = GetIt.instance<Dio>();
  String accessToken = '';
  List<SpotifyInformationEntity> tracks = [];
  AudioPlayer audioPlayer = AudioPlayer();
  int playingIndex = -1;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String newAccessToken = await getAccessToken();
      setState(() {
        accessToken = newAccessToken;
      });



      debugPrint(accessToken);

      await getInitList().then((value) => setState(() {
            loading = false;
          }));
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future getInitList() async {
    var featuredData = await dio.get(
        'https://api.spotify.com/v1/playlists/37i9dQZEVXbMDoHDwVN2tF/tracks?offset=0&limit=50',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));
    debugPrint(featuredData.toString());

    List<Map<String, dynamic>> listOfFeaturedItems =
        List<Map<String, dynamic>>.from(
            jsonDecode(featuredData.toString())['items']);

    List<SpotifyInformationEntity> popularTracks = listOfFeaturedItems.map((e) {
      return SpotifyInformationEntity(
        albumImageUrl: e['track']['album']['images'][2]['url'],
        spotifyExternalUrl: e['track']['external_urls']['spotify'],
        previewUrl: e['track']['preview_url'] ?? '',
        name: e['track']['name'],
        artist: List<String>.from(
            e['track']['artists'].map((e) => e['name']).toList()),
      );
    }).toList();
    debugPrint(popularTracks.toString());

    setState(() {
      tracks.addAll(popularTracks);
    });

    // return listOfFeaturedItems;
  }

  Future<String> getAccessToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: "8a3ed83942d24473af89f1ebd19781fc",
          redirectUrl: "finder.love.app://callback",
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing,'
              'user-top-read');
      return authenticationToken;
    } on PlatformException catch (e) {
      debugPrint(e.code);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      return Future.error('not implemented');
    }
  }

  Future search(String value) async {
    try {
      final result = await dio.get(
          'https://api.spotify.com/v1/search?q=$value&type=track&offset=0&limit=30',
          options: Options(headers: {'authorization': 'Bearer $accessToken'}));
      // debugPrint(result.toString());
      final data = jsonDecode(result.toString());
      debugPrint(data.toString());
      final filteredListOfMaps = List.from(data['tracks']['items']);
      final filteredListOfTracks = filteredListOfMaps
          .map((e) => SpotifyInformationEntity(
                albumImageUrl: e['album']['images'][2]['url'],
                spotifyExternalUrl: e['external_urls']['spotify'],
                previewUrl: e['preview_url'] ?? '',
                name: e['name'],
                artist: List<String>.from(
                    e['artists'].map((e) => e['name']).toList()),
              ))
          .toList();
      setState(() {
        tracks.clear();
        tracks.addAll(filteredListOfTracks);
      });
    } on DioException catch (e) {
      debugPrint(e.message.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserSpotify(String albumImageUrl, String spotifyExternalUrl,
      String previewUrl, String name, List<String> artist) async {
    final spotify = SpotifyInformationEntity(
        albumImageUrl: albumImageUrl,
        spotifyExternalUrl: spotifyExternalUrl,
        previewUrl: previewUrl,
        name: name,
        artist: artist);

    await GetIt.instance<UserRepository>().addSpotify(spotify);
  }

  Future deleteUserSpotify() async {
    await GetIt.instance<UserRepository>().addSpotify(null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade200
            : Colors.grey.shade900,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      deleteUserSpotify();
                      context.pop();
                    },
                    child: Ink(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.block_outlined,size: 35,),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            S().spotifyHideMusic,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.0.h, left: 15.0.h,bottom: 15),
                    child:  Column(
                      children: [
                        Text(
                          S().spotifyPopularTitle,
                          style:
                              const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  if (tracks.isNotEmpty)
                    Ink(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tracks.length,
                        itemBuilder: (context, index) {
                          final item = tracks[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0.h,left: 15,right: 8),
                            child: InkWell(
                              onTap: () {
                                updateUserSpotify(
                                    item.albumImageUrl,
                                    item.spotifyExternalUrl,
                                    item.previewUrl ?? '',
                                    item.name,
                                    item.artist);
                                context.pop({
                                  "itemSpotify": item,
                                }
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                          imageUrl: item.albumImageUrl,
                                          placeholder: (context, url) => SvgPicture.asset(
                                            "spotify".withIcon(),
                                            width: 45.w,
                                            height: 45.h,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 5.0),
                                                  child: SvgPicture.asset(
                                                    "spotify".withIcon(),
                                                    width: 12.w,
                                                    height: 12.h,
                                                  ),
                                                ),
                                                Text(
                                                  item.artist.join(', '),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (playingIndex == index) {
                                              audioPlayer.stop();
                                              setState(() {
                                                playingIndex = -1;
                                              });
                                            } else {
                                              audioPlayer.setUrl(item.previewUrl);
                                              audioPlayer.play();
                                              setState(() {
                                                playingIndex = index;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            playingIndex == index
                                                ? Icons.pause_rounded
                                                : Icons.play_arrow_rounded,
                                            size: 30,
                                            color: Colors.green,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
                child: Row(

                    children: [
                      IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back)),
                      SizedBox(
                        width: 10.h,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle( color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black : Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).brightness == Brightness.light ? Colors.grey[200] : Colors.grey[800],
                              constraints: const BoxConstraints(
                                maxHeight: 40,
                              ),

                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                              hintText: S.current.spotifySearchHint,
                              hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade600 : Colors.grey, fontSize: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8))),


                          onChanged: (value) async {
                            if (audioPlayer.playing) {
                              audioPlayer.stop();
                            }
                            setState(() {
                              playingIndex = -1;
                            });
                            await search(value);
                          },
                        ),
                      ),

                    ],
                ),
              ),
            ),
            if (loading)
              Container(
                color: Colors.transparent,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Stack(
                  children: [
                    // Nền mờs
                    Opacity(
                      opacity: 0.7,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    // Loading Indicator
                    Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: const Color(0xFFd73730),
                        size: 70,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
