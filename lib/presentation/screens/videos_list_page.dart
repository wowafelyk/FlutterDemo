import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/domain/entities/video_entity.dart';
import 'package:flutter_demo/injection/injector.dart';
import 'package:flutter_demo/presentation/block/video_event.dart';
import 'package:flutter_demo/presentation/block/video_state.dart';
import 'package:flutter_demo/presentation/block/videos_list_block.dart';
import 'package:transparent_image/transparent_image.dart';

class VideosListPage extends StatelessWidget {
  const VideosListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos list'),
      ),
      body: BlocProvider(
        create: (_) => injector.get<VideosListBloc>(),
        child: const VideosView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          injector
              .get<VideosListBloc>()
              .add(VideoSearchEvent(searchString: "Agent 007"));
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class VideosView extends StatelessWidget {
  const VideosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getMainBody(context);
  }

  Widget _getMainBody(BuildContext context) {
    final VideoState state = context.watch<VideosListBloc>().state;
    switch (state.status) {
      case VideoStateStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case VideoStateStatus.success:
        return VideosLisView(
            items: (state as SuccessfulLoadingState).videosList);
      case VideoStateStatus.initial:
        return const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
              child: Text(
            "Press button to start search video by titleQuery: \"Agent 007\"",
            maxLines: 3,
            textAlign: TextAlign.center,
          )),
        );
      case VideoStateStatus.loading:
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

class VideosLisView extends StatelessWidget {
  const VideosLisView({Key? key, required this.items}) : super(key: key);

  final List<VideoEntity> items;

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(child: Text('no content'))
        : ListView.builder(
      itemExtent: 90,
            itemBuilder: (BuildContext context, int index) {
              return ItemHolder(
                item: items[index],
              );
            },
            itemCount: items.length,
          );
  }
}

class ItemHolder extends StatelessWidget {
  const ItemHolder({
    Key? key,
    required this.item,
  }) : super(key: key);

  final VideoEntity item;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        child: ListTile(
          leading: SizedBox(
              height: 72,
              width: 72,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.poster,
              )),
          title: Text(item.name),
          subtitle: Text('Type: ${item.type}   Year: ${item.year}'),
          isThreeLine: true,
        ),
      ),
    );
  }
}
