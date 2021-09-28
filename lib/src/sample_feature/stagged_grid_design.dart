import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggedGridDesign extends StatelessWidget {
  const StaggedGridDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        itemCount: 20,
        primary: false,
        crossAxisCount: 2,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        itemBuilder: (context, index) => _Tile('https://source.unsplash.com/random?sig=$index', index + 1));
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.source, this.index);

  final String source;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(source),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Vincent Van Gogh',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
