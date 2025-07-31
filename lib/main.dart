import 'package:flutter/material.dart';
import 'package:news_app/ThemeProvider.dart';
import 'package:news_app/service/Service.dart';
import 'package:provider/provider.dart';
import 'WebView.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeProvider(), child: MyApp(),),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: context.watch<ThemeProvider>().getThemeValue()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New App"), actions: [
        Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
    return Switch(
    value: themeProvider.getThemeValue(),
    onChanged: (newValue) {
    themeProvider.updateThemeMode(value: newValue);
    },
    );
    })]),
    body: FutureBuilder(
    future: Services.getnew(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    }
    // ❌ Error
    if (snapshot.hasError) {
    print('Error: ${snapshot.error}');
    return Center(child: Text('Error: ${snapshot.error}'));
    }
    // 🛑 No Data
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return const Center(child: Text("No news available"));
    }

    final newList = snapshot.data!;

    return ListView.builder(
    itemCount: snapshot.data!.length,
    itemBuilder: (__, index) {
    var data = newList[index];
    return GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    WebViewExample(uri: data.url, title: data.source!.name),
    ),
    );
    },
    child: Card(
    elevation: 5,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
    leading: Image.network(
    data.urlToImage,
    height: 100,
    width: 100,
    ),
    title: Text(
    data.title,
    style: TextStyle(fontSize: 15),

    )
      ,
    ),
    ),
    ),
    );
    },
    );
    },
    )
    ,
    );
  }
}
