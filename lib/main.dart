import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Row(children: [
          new Expanded(
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text('Oeschinen Lake Campground',
                        style: new TextStyle(fontWeight: FontWeight.bold))),
                new Text('Kandersteg, Switzerland',
                    style: new TextStyle(color: Colors.grey[500]))
              ])),
          new Icon(Icons.star, color: Colors.red[500]),
          new Text('41')
        ]));

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Icon(icon, color: color),
            new Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: new Text(label,
                    style: new TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: color)))
          ]);
    }

    Widget buttonSection = new Container(
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE')
        ]));

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris nec turpis vitae libero fringilla molestie. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed facilisis odio nec arcu volutpat finibus. Mauris in ullamcorper ipsum, nec hendrerit eros. Fusce semper, eros nec luctus iaculis, orci eros pharetra magna, nec hendrerit quam nibh vitae lorem. Aliquam eget tempor ipsum. Pellentesque eget mi tellus. Ut vestibulum felis laoreet cursus imperdiet. Donec sagittis iaculis dui a pulvinar. Nam elementum nisi eros, ac condimentum massa rutrum et. Mauris vitae est tincidunt enim scelerisque vestibulum quis sit amet est. Vivamus elementum non augue sit amet vehicula. Duis gravida est eget libero condimentum luctus. Curabitur sodales orci at euismod molestie. Nullam nec mattis nibh. In sit amet condimentum purus, a euismod elit.
        ''',
        softWrap: true,
      ),
    );

    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
            body: new CustomScrollView(slivers: <Widget>[
          new SliverAppBar(
            pinned: true,
            expandedHeight: _kFlexibleSpaceMaxHeight,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text('Top Lakes'),
              // TODO(abarth): Wire up to the parallax in a way that doesn't pop during hero transition.
              background:
                  new _AppBarBackground(animation: kAlwaysDismissedAnimation),
            ),
          ),
          new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
            titleSection,
            buttonSection,
            textSection,
          ])),
        ])));
  }
}

const double _kFlexibleSpaceMaxHeight = 256.0;

class _BackgroundLayer {
  _BackgroundLayer({int level, double parallax})
      : assetName = 'images/lake.jpg',
        parallaxTween = new Tween<double>(begin: 0.0, end: parallax);
  final String assetName;
  final Tween<double> parallaxTween;
}

final List<_BackgroundLayer> _kBackgroundLayers = <_BackgroundLayer>[
  new _BackgroundLayer(level: 0, parallax: _kFlexibleSpaceMaxHeight),
  new _BackgroundLayer(level: 1, parallax: _kFlexibleSpaceMaxHeight),
  new _BackgroundLayer(level: 2, parallax: _kFlexibleSpaceMaxHeight / 2.0),
  new _BackgroundLayer(level: 3, parallax: _kFlexibleSpaceMaxHeight / 4.0),
  new _BackgroundLayer(level: 4, parallax: _kFlexibleSpaceMaxHeight / 2.0),
  new _BackgroundLayer(level: 5, parallax: _kFlexibleSpaceMaxHeight)
];

class _AppBarBackground extends StatelessWidget {
  _AppBarBackground({Key key, this.animation}) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Stack(
              children: _kBackgroundLayers.map((_BackgroundLayer layer) {
            return new Positioned(
                top: -layer.parallaxTween.evaluate(animation),
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: new Image.asset(layer.assetName,
                    fit: BoxFit.cover, height: _kFlexibleSpaceMaxHeight));
          }).toList());
        });
  }
}
