import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Data Desktop Client',
      themeMode: ThemeMode.light,
      darkTheme: FluentThemeData.dark(),
      theme: FluentThemeData.light(),
      home: FluentTheme(
          data: FluentThemeData(
            accentColor: Colors.pocketData,
          ),
          child: MyHomePage()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController serverUrlController = TextEditingController();

  int _currentPageIndex = 0;

  String selectedContact = '';
  final contacts = ['Kendall', 'Collins'];


  @override
  Widget build(BuildContext context) {

    return NavigationView(
      pane: NavigationPane(
        onItemPressed: (i){
          _currentPageIndex = i;
          setState(() {});
        },
        selected: _currentPageIndex,
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
            body: Center(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 30),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/pd_logo.png', height: 40,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                          'Hi, Welcome Back!',
                          style: FluentTheme.of(context).typography.subtitle
                      ),
                      SizedBox(height: 20,),
                      Text(
                          'Enter your details to get sign in to your account',
                          style: FluentTheme.of(context).typography.caption
                      ),
                      SizedBox(height: 20,),
                      Icon(FluentIcons.reminder_person),
                      const SizedBox(height: 10,),
                      PasswordBox(
                        placeholder: 'Username',
                        controller: usernameController,
                        revealMode: PasswordRevealMode.visible,
                      ),
                      SizedBox(height: 20,),
                      Icon(FluentIcons.password_field),
                      SizedBox(height: 10,),
                      PasswordBox(
                        placeholder: 'Password',
                        controller: passwordController,
                        revealMode: PasswordRevealMode.peek,
                      ),
                      SizedBox(height: 20,),
                      Icon(FluentIcons.link),
                      SizedBox(height: 10,),
                      PasswordBox(
                        placeholder: 'Server URL',
                        controller: serverUrlController,
                        revealMode: PasswordRevealMode.visible,
                      ),
                      SizedBox(height: 20,),
                      Icon(FluentIcons.sync_folder),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: PasswordBox(
                              enabled: false,
                              placeholder: 'Sync Directory',
                              controller: serverUrlController,
                              revealMode: PasswordRevealMode.visible,
                            ),
                          ),
                          SizedBox(width: 20,),
                          FilledButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) => Colors.black),
                              ),
                              child: Text('Select'),
                              onPressed: (){
                                final file = DirectoryPicker()
                                              ..title = 'Select a directory';

                                final result = file.getDirectory();
                                if (result != null) {
                                  print(result.path);
                                }
                              },
                          )
                        ],
                      ),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                              child: Text('Login'),
                              onPressed: () async {
                                await displayInfoBar(context, builder: (context, close) {
                                  return InfoBar(
                                    title: const Text('Wowowow'),
                                    action: IconButton(
                                      icon: const Icon(FluentIcons.clear),
                                      onPressed: close,
                                    ),
                                    severity: InfoBarSeverity.success,
                                  );
                                });
                              }
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          PaneItem(
              icon: Icon(FluentIcons.log_remove),
            title: Text('Dashboard'),
            body: Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quota', style: FluentTheme.of(context).typography.title,),
                  SizedBox(height: 20),
                  Text('60% used', style: FluentTheme.of(context).typography.caption,),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: ProgressBar(value: 60, strokeWidth: 12,),),
                      SizedBox(width: 20,),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ListTile.selectable(
                              title: Text(contact),
                              selected: selectedContact == contact,
                              onSelectionChange: (v) => setState(() => selectedContact = contact),
                            );
                          }
                      )
                  )
                ],
              ),
            )
          )
        ]
      ),
    );
  }
}
