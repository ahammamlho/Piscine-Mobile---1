import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _location = '';

  void _search(String value) {
    setState(() {
      _location = value.trim();
    });
  }

  void _useGeolocation() {
    _searchController.clear();
    setState(() {
      _location = 'Geolocation';
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextField(
            controller: _searchController,
            onSubmitted: _search,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Search location...',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _useGeolocation,
              icon: const Icon(Icons.location_on),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            TabContent(title: 'Currently', location: _location),
            TabContent(title: 'Today', location: _location),
            TabContent(title: 'Weekly', location: _location),
          ],
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.white,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.access_time), text: 'Currently'),
              Tab(icon: Icon(Icons.today), text: 'Today'),
              Tab(icon: Icon(Icons.calendar_month), text: 'Weekly'),
            ],
          ),
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  const TabContent({super.key, required this.title, required this.location});

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 16),
          Text(location, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
