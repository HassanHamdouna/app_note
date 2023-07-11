import 'package:app_note/bloc/bloc/images_bloc.dart';
import 'package:app_note/bloc/events/crud_event.dart';
import 'package:app_note/bloc/states/curd_state.dart';
import 'package:app_note/utils/context_extenssion.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/app_circular_progress.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ImagesBloc>(context).add(ReadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            ' images ',
          ),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/upload_images_screen'),
                icon: const Icon(Icons.camera_alt))
          ],
        ),
        body: BlocConsumer<ImagesBloc, CrudState>(
            listenWhen: (previous, current) =>
                current is ProcessState &&
                current.processType == ProcessType.delete,
            listener: (context, state) {
              state as ProcessState;
              context.showSnackBar(
                  message: state.message, error: !state.sussecc);
            },
            buildWhen: (previous, current) => current is ReadState,
            builder: (context, state) {
              if (state is LoadingState) {
                return const AppCircularProgress();
              } else if (state is ReadState && state.reference.isNotEmpty) {
                return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.reference.length,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(children: [
                          FutureBuilder<String>(
                              future: state.reference[index].getDownloadURL(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const AppCircularProgress();
                                } else if (snapshot.hasData) {
                                  return CachedNetworkImage(
                                    imageUrl: snapshot.data!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            const AppCircularProgress(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  );
                                } else {
                                  return const Center(
                                    child: Icon(Icons.image),
                                  );
                                }
                              }),
                          Row(
                            children: [
                              Text(state.reference[index].name),
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ImagesBloc>(context)
                                        .add(DeleteEvent(index));
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          )
                        ]),
                      );
                    });
              } else {
                return const Center(
                  child: Text('empty'),
                );
              }
            }));
  }
}
