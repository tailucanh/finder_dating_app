import 'dart:io';
import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/entities/message.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/params/tokens.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/chat_detail/chat_detail_provider.dart';
import 'package:chat_app/ui/chat_detail/widgets/bottom_call_video.dart';
import 'package:chat_app/ui/chat_detail/widgets/custom_widget_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../generated/l10n.dart';
import '../widgets/app_cache_avatar.dart';
import 'chat_detail_cubit.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => ChatDetailCubit()),
        ChangeNotifierProvider(
            create: (context) =>
                ChatProvider(idChat: model['idChat'], idUser: model['idUser'])),
      ],
      child: ChatDetailChildPage(agr: model),
    );
  }
}

class ChatDetailChildPage extends StatefulWidget {
  const ChatDetailChildPage({super.key, required this.agr});

  final Map<String, dynamic> agr;

  @override
  State<ChatDetailChildPage> createState() => _ChatDetailChildPageState();
}

class _ChatDetailChildPageState extends State<ChatDetailChildPage> {
  late TextEditingController textEditingController;
  File? imageFile;
  File? audioFile;
  bool isRecording = false;
  late RecorderController controller;
  late ChatDetailCubit _cubit;
  final record = AudioRecorder();
  int suggestedMessageIndex = 0;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _cubit = BlocProvider.of<ChatDetailCubit>(context);
    _cubit.loadInitialData();
    scrollController = ScrollController()
      ..addListener(() {
        loadMoreListener();
      });
    context.read<ChatProvider>().fetchData();
    _initialiseControllers();
  }

  void loadMoreListener() {
    if (scrollController.offset == scrollController.position.minScrollExtent) {}
  }

  void _initialiseControllers() {
    controller = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void pickImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        setState(() {
          imageFile = File(xFile.path);
        });
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();

    record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<ChatProvider>().fetchData(),
        builder: (context, snapshot) {
          UserEntity? targetUser = context.watch<ChatProvider>().targetUser;
          UserEntity? currentUser = context.watch<ChatProvider>().currentUser;
          Tokens? tokensTime = context.watch<ChatProvider>().tokensTimme;

          return Scaffold(
            appBar: _buildAppbar(targetUser, currentUser, tokensTime),
            body: _buildBodyWidget(targetUser, currentUser),
          );
        });
  }

  Widget _buildBodyWidget(UserEntity? targetUser, UserEntity? currentUser) {
    return SafeArea(
      child: Column(
        children: [
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),
          _buildChatList(targetUser, currentUser?.fullName),
          BlocBuilder<ChatDetailCubit, ChatDetailState>(
              builder: (context, state) {
                if (state.isRecording != null && state.isRecording == false) {
                  return _buildMessageInput(currentUser?.fullName ?? 'Finder');
                } else {
                  return _buildRecordController();
                }
              })
        ],
      ),
    );
  }

  Widget _buildRecordController() {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            controller.reset();
            await controller.stop(false);
            _cubit.setRecording(false);
          },
          child: const Icon(Icons.delete),
        ),
        Expanded(
            child: AudioWaveforms(
              enableGesture: true,
              size: Size(MediaQuery.of(context).size.width / 2, 50),
              recorderController: controller,
              waveStyle: const WaveStyle(
                waveColor: Colors.blueAccent,
                extendWaveform: true,
                showMiddleLine: false,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 18),
              margin: const EdgeInsets.symmetric(horizontal: 15),
            )),
        InkWell(
          onTap: () async {
            controller.reset();
            await controller.stop(false).then((value) async {
              await context
                  .read<ChatProvider>()
                  .uploadAudioFile(File(value!))
                  .then((audioUrl) async {
                await context
                    .read<ChatProvider>()
                    .chatMessage(
                    message: Message(
                        message: "[Audio]",
                        idUser: widget.agr['idUser'],
                        createAt: DateTime.now()
                            .millisecondsSinceEpoch
                            .toString(),
                        idItemChat: const Uuid().v1(),
                        type: 2,
                        audioUrl: audioUrl))
                    .then((value) => _cubit.setRecording(false));
              });
            });
          },
          child: const Icon(Icons.send),
        ),
      ],
    );
  }

  Widget _buildMessageInput(String? currentUserName) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              pickImage();
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: const Icon(
                  Icons.image_outlined,
                  size: 20,
                )),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () async {
              await controller.record();
              _cubit.setRecording(true);
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: const Icon(
                  Icons.mic_outlined,
                  size: 20,
                )),
          ),
          const SizedBox(
            width: 8,
          ),
          _buildContentInput(currentUserName),
        ],
      ),
    );
  }

  Widget _buildContentInput(String? username) {
    return imageFile == null
        ? _buildTextMessageInput(username)
        : _buildImageMessageInput(username);
  }

  Widget _buildTextMessageInput(String? username) {
    return Expanded(
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 4,
        onChanged: (value) {
          setState(() {
            textEditingController.text = value;
          });
        },
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.sp),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            constraints: BoxConstraints(
                minHeight: 30,
                maxHeight: 40,
                minWidth: MediaQuery.of(context).size.width),
            hintText: S().messageScreenYourTurnText,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey
                      : Colors.white,
                )),
            suffixIcon: GestureDetector(
              onTap: () async {
                if (textEditingController.text.isNotEmpty) {
                  context.read<ChatProvider>().chatMessage(
                      title: username ?? 'Finder',
                      message: Message(
                          message: textEditingController.text,
                          idUser: widget.agr['idUser'],
                          createAt:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          idItemChat: const Uuid().v1(),
                          imageUrl: ''));
                  textEditingController.clear();
                }
              },
              child: Icon(
                Icons.send_rounded,
                color: textEditingController.text.isNotEmpty
                    ? Colors.blueAccent
                    : Colors.grey.shade300,
              ),
            )),
      ),
    );
  }

  Widget _buildImageMessageInput(String? username) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey
                    : Colors.white,
              )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      imageFile!,
                      width: 60,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          imageFile = null;
                        });
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: context.read<ChatProvider>().isSending
                    ? const CircularProgressIndicator(
                  color: Colors.blueAccent,
                )
                    : GestureDetector(
                  onTap: () async {
                    if (imageFile == null ||
                        context.read<ChatProvider>().isSending) return;
                    context.read<ChatProvider>().setIsSending(true);
                    await context
                        .read<ChatProvider>()
                        .uploadFile(imageFile!,
                        context.read<ChatProvider>().idChat!)
                        .then((imageUrl) async {
                      await context
                          .read<ChatProvider>()
                          .chatMessage(
                          title: username ?? 'Finder',
                          message: Message(
                            idUser: widget.agr['idUser'],
                            message: '[Image]',
                            createAt: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            idItemChat: const Uuid().v1(),
                            imageUrl: imageUrl,
                            type: 1,
                          ))
                          .then((value) {
                        context.read<ChatProvider>().setIsSending(false);
                        setState(() {
                          imageFile = null;
                        });
                      });
                    });

                    textEditingController.clear();
                  },
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildChatList(UserEntity? targetUser, String? currentUserName) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, top: 8),
        child: StreamBuilder<List<Message>>(
            stream: context.watch<ChatProvider>().listMessage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return _buildSuggestedMessage(targetUser, currentUserName);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    reverse: true,
                    itemBuilder: (context, index) => ItemMessage(
                      audioUrl: snapshot.data![index].audioUrl ?? '',
                      param: snapshot.data![index].message ?? "",
                      right: snapshot.data![index].idUser ==
                          helpersFunctions.idUser,
                      avatarTarget: targetUser?.avatar ?? '',
                      activeStatus: targetUser?.activeStatus ?? false,
                      time: HelpersDataUser
                          .formatMillisecondsSinceEpochToDateAndTime(
                          snapshot.data![index].createAt ?? ""),
                      type: snapshot.data![index].type ?? 0,
                      imageUrl: snapshot.data![index].imageUrl ?? '',
                    ),
                  );
                }
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }

  Widget _buildSuggestedMessage(
      UserEntity? targetUser, String? currentUserName) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: S().startChatTitle,
                      style: const TextStyle(fontSize: 15)),
                  TextSpan(
                      text: targetUser?.fullName ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w600))
                ])),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade300
                      : AppColors.black700,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade200
                          : Colors.grey.shade600,
                      blurRadius: 7,
                      offset: const Offset(2, 3),
                    ),
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade200
                          : Colors.grey.shade600,
                      blurRadius: 7,
                      offset: const Offset(-1, -2),
                    ),
                  ]),
              margin: EdgeInsets.only(top: 20.h),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Color(0XFFFF5050), Color(0XFFff0066)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
                    ),
                    child: Icon(
                      Icons.message_rounded,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      if (suggestedMessageIndex <
                          HelpersDataUser.suggestedMessagesList().length - 1) {
                        setState(() {
                          suggestedMessageIndex++;
                        });
                      } else {
                        setState(() {
                          suggestedMessageIndex = 0;
                        });
                      }
                    },
                    child: Ink(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.refresh,
                                size: 17.sp,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                S().seeOtherSuggestionTitle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6.w,
                          ),
                          Text(
                            HelpersDataUser.suggestedMessagesList()[
                            suggestedMessageIndex],
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          context.read<ChatProvider>().chatMessage(
                              title: currentUserName ?? 'Finder',
                              message: Message(
                                  message:
                                  HelpersDataUser.suggestedMessagesList()[
                                  suggestedMessageIndex],
                                  idUser: widget.agr['idUser'],
                                  createAt: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  idItemChat: const Uuid().v1(),
                                  imageUrl: ''));
                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          child: Text(
                            S().sendSuggestedMessageButtonTitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                  Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppbar(
      UserEntity? targetUser, UserEntity? currentUser, Tokens? tokensTime) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          Stack(
            children: [
              AppCacheAvatar(
                linkAvatar: targetUser?.avatar,
                status: targetUser?.activeStatus ?? false,
                size: 40,
                isCardStory: true,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                targetUser?.fullName ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.sp,
                ),
                maxLines: 1,
              ),
              const SizedBox(
                height: 2,
              ),
              (targetUser?.activeStatus ?? false)
                  ? Text(
                S().active,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              )
                  : const SizedBox(),
              (!(targetUser?.activeStatus ?? false) &&
                  HelpersDataUser.calculateTimeDifference(
                      tokensTime?.timeActive ?? 0) !=
                      0)
                  ? Text(
                '${S().titleActive_1} ${HelpersDataUser.strCalculateTimeDifference(tokensTime?.timeActive ?? 0)} ${S().titleActive_2}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _showBottomCallVideo(
              avatar1: currentUser?.avatar ?? '',
              avatar2: targetUser?.avatar ?? '',
              callVideoView: ZegoSendCallInvitationButton(
                  buttonSize: const Size(50, 50),
                  iconSize: const Size(50, 50),
                  icon: ButtonIcon(
                      icon: const Icon(
                        Icons.videocam_rounded,
                        color: Colors.transparent,
                      ),
                      backgroundColor: Colors.transparent),
                  invitees: [
                    ZegoUIKitUser(
                      id: helpersFunctions.callId,
                      name: helpersFunctions.fullName,
                    ),
                    ZegoUIKitUser(
                      id: context.read<ChatProvider>().targetUser?.uidCall ??
                          "",
                      name: context.read<ChatProvider>().targetUser?.fullName ??
                          "",
                    )
                  ],
                  resourceID: 'zero_call',
                  isVideoCall: true),
            );
          },
          icon: const Icon(
            Icons.videocam_rounded,
            color: Colors.blueAccent,
            size: 25,
          ),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(context)
                .pushNamed(AppRoutes.reportUser, extra: targetUser?.uid ?? '');
          },
          icon: const Icon(
            Icons.shield_rounded,
            color: Colors.blueAccent,
            size: 25,
          ),
        ),
      ],
    );
  }

  void _showBottomCallVideo(
      {required String avatar1,
        required String avatar2,
        required Widget callVideoView}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => BottomCallVideo(
            avatar1: avatar1, avatar2: avatar2, callVideoView: callVideoView));
  }
}
