  import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'firebase_options.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:email_validator/email_validator.dart';
  import 'package:http/http.dart' as http;
  import 'stockModel.dart';
  import 'constants.dart';
  import 'api_service.dart';
  
  
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  }
  
  class MyApp extends StatelessWidget {
    const MyApp({super.key});
  
    @override
    Widget build(BuildContext context) {
      return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
    }
  }
  
  class Home extends StatefulWidget {
    const Home({super.key});
    @override
    State<Home> createState() => _HomeState();
  }
  
  class _HomeState extends State<Home>{
    @override
    Widget build(BuildContext context) {
      const Color _teal = Color(0xFF2EC4B6);
      const Color _lightTeal = Color(0xFFC8ECEA);

      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: _teal,
          child: Column(
            children: [
              SizedBox(height: 150),
  
              Text('WealthWay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
  
              SizedBox(height: 30),
  
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance,
                  size: 50,
                  color: Colors.black,
                ),
              ),
  
              SizedBox(height: 30),
  
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _lightTeal,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
  
                        Text('Small Steps.\nBig Savings.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
  
                        SizedBox(height: 15),
  
                        Text('Your journey to financial freedom starts here. '
                              'Secure your savings, set your goals, and take control '
                              'of your future today.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
  
                        SizedBox(height: 30),
  
                        SizedBox(
                          width: 230,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Login()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Log In',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
  
                        SizedBox(height: 16),
  
                        SizedBox(
                          width: 230,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Registration()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white70,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Register',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  
  class Registration extends StatefulWidget {
    const Registration({super.key});
  
    @override
    State<Registration> createState() => _RegistrationState();
  }
  
  class _RegistrationState extends State<Registration> {
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    bool _isLoading = false;
  
    @override
    Widget build(BuildContext context) {
      const Color _teal = Color(0xFF2EC4B6);
      const Color _lightTeal = Color(0xFFC8ECEA);
  
      return Scaffold(
        backgroundColor: _teal,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 50,),
                    onPressed: () => Navigator.pop(context),
                  ),
  
                  SizedBox(height: 16),
  
                  Center(
                    child: Text('Join Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
  
                  SizedBox(height: 8),
  
                  Center(
                    child: Text('Create a Free Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
  
                  SizedBox(height: 24),
  
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _lightTeal,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text('Registration',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
  
                          SizedBox(height: 24),
  
                          Text('Your Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 10),
  
                          Row(
                            children: [
                              Expanded(
                                child: _roundedField(
                                  hint: 'First Name',
                                  controller: _firstNameController,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: _roundedField(
                                  hint: 'Last Name',
                                  controller: _lastNameController,
                                ),
                              ),
                            ],
                          ),
  
                          SizedBox(height: 20),
  
                          Text('Email Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 10),
  
                          _roundedField(
                            hint: 'Your Email Address',
                            suffixIcon: Icon(Icons.mail_outline),
                            controller: _emailController,
                          ),
  
                          SizedBox(height: 20),
  
                          Text('Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 10),
  
                          _roundedField(
                            hint: '8 char min',
                            obscure: true,
                            controller: _passwordController,
                          ),
  
                          SizedBox(height: 20),
  
                          Text('Confirm Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 10),
  
                          _roundedField(
                            hint: 'Confirm Password',
                            obscure: true,
                            controller: _confirmPasswordController,
                          ),
  
                          SizedBox(height: 24),
  
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() => _isLoading = true);
  
                                  final error = await AuthService.instance.registerUser(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    confirmPassword: _confirmPasswordController.text,
                                  );
  
                                  setState(() => _isLoading = false);
  
                                  if (error != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)),);
                                  } else {
                                    Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) => const Home()),);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 4,
                                ),
                                child: Text('Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  
    Widget _roundedField({
      required String hint,
      TextEditingController? controller,
      Widget? suffixIcon,
      bool obscure = false,
    }) {
      return TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      );
    }
  }
  
  class Login extends StatefulWidget {
    const Login({super.key});
  
    @override
    State<Login> createState() => _LoginState();
  }
  
  class _LoginState extends State<Login> {
    final _loginEmailController = TextEditingController();
    final _loginPasswordController = TextEditingController();
  
    bool _isLoggingIn = false;
    @override
    Widget build(BuildContext context) {
      const teal = Color(0xFF2EC4B6);
      const lightTeal = Color(0xFFC8ECEA);
  
      return Scaffold(
        backgroundColor: teal,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
  
                  SizedBox(height: 16),
  
                  Center(
                    child: Text('Hello',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text('Welcome Back!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
  
                  SizedBox(height: 24),
  
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: lightTeal,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text('Login Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
  
                          SizedBox(height: 24),
  
                          Text('Email Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 10),
  
                          _roundedField(
                            hint: 'Your Email Address',
                            suffixIcon: Icon(Icons.mail_outline),
                            controller: _loginEmailController,
                          ),
  
                          SizedBox(height: 20),
  
                          Text('Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 10),
  
                          _roundedField(
                            hint: '8 char min',
                            obscure: true,
                            controller: _loginPasswordController,
                          ),
  
                          SizedBox(height: 10),
  
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Forgot password flow
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text('Forgot Password?',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
  
                          SizedBox(height: 24),
  
                       SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() => _isLoggingIn = true);
  
                                final error = await AuthService.instance.loginUser(
                                  email: _loginEmailController.text,
                                  password: _loginPasswordController.text,
                                );
  
                                setState(() => _isLoggingIn = false);
  
                                if (error != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const Navigation()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 4,
                              ),
                              child: Text('Login Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
  
                          SizedBox(height: 20),
  
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Registration(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text('Create New Account',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  
    // same helper from registration
    Widget _roundedField({
      required String hint,
      TextEditingController? controller,
      Widget? suffixIcon,
      bool obscure = false,
    }) {
      return TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      );
    }
  }
  
  class Navigation extends StatefulWidget {
    const Navigation({super.key});
  
    @override
    State<Navigation> createState() => _NavigationState();
  }
  
  class _NavigationState extends State<Navigation> {
    int _selectedIndex = 2;
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            Budget(key: ValueKey(_selectedIndex)),
            Invest(key: ValueKey(_selectedIndex)),
            Dashboard(key: ValueKey(_selectedIndex)),
            Spending(key: ValueKey(_selectedIndex)),
            Settings(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Budget"),
            BottomNavigationBarItem(icon: Icon(Icons.savings), label: "Invest"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Spending"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      );
    }
  }
  
  class Dashboard extends StatefulWidget {
    const Dashboard({super.key});
  
    @override
    State<Dashboard> createState() => _DashboardState();
  }
  
  class _DashboardState extends State<Dashboard> {
    static const Color _teal = Color(0xFF2EC4B6);
    static const Color _lightTeal = Color(0xFFC8ECEA);
  
    final FirebaseFirestore _db = FirebaseFirestore.instance;
  
    AppUser? _user;
    bool _isLoading = true;
  
    double _cash = 0;
    double _weeklyGoal = 0;
    double _spentThisWeek = 0;
  
    DateTime? _weekStart;
    DateTime? _weekEnd;

    final Map<String, _CategorySummary> _categories = {};

    final List<String> _categoryOrder = const [
      'Shopping',
      'Groceries',
      'Gas',
      'Eating Out',
      'Entertainment',
      'Subscriptions',
    ];
  
    @override
    void initState() {
      super.initState();
      _loadDashboardData();
    }

    Future<void> _loadDashboardData() async {
      setState(() {
        _isLoading = true;
      });

      try {
        _user = await SessionManager.instance.getCurrentUser();

        if (_user == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No logged in user found')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }

        final userRef = _db.collection('users').doc(_user!.id);
        final userDoc = await userRef.get();
        final userData = userDoc.data();

        if (userData != null) {
          if (userData.containsKey('cash')) {
            _cash = (userData['cash']).toDouble();
          } else {
            _cash = 0;
          }

          if (userData.containsKey('weeklySpendingGoal')) {
            _weeklyGoal = (userData['weeklySpendingGoal']).toDouble();
          } else {
            _weeklyGoal = 0;
          }
        }

        Timestamp? lastTopUpTs = null;
        if (userData != null && userData.containsKey('lastCashTopUp')) {
          lastTopUpTs = userData['lastCashTopUp'] as Timestamp?;
        }

        final now = DateTime.now();

        if (_weeklyGoal > 0) {
          if (lastTopUpTs == null) {
            await userRef.update({
              'cash': _cash + _weeklyGoal,
              'lastCashTopUp': Timestamp.fromDate(now),
            });
            _cash = _cash + _weeklyGoal;
          } else {
            final lastTopUp = lastTopUpTs.toDate();

            final lastWeek = DateTime(
              lastTopUp.year,
              lastTopUp.month,
              lastTopUp.day - lastTopUp.weekday,
            );

            final currentWeek = DateTime(
              now.year,
              now.month,
              now.day - now.weekday,
            );

            if (currentWeek.isAfter(lastWeek)) {
              await userRef.update({
                'cash': _cash + _weeklyGoal,
                'lastCashTopUp': Timestamp.fromDate(now),
              });
              _cash = _cash + _weeklyGoal;
            }
          }
        }

        final monday = DateTime(now.year, now.month, now.day - (now.weekday - DateTime.monday),);

        final nextMonday = monday.add(Duration(days: 7));

        _weekStart = monday;
        _weekEnd = nextMonday.subtract(Duration(days: 1));

        final spendings = await userRef.collection('spendings').where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(monday))
            .where('date', isLessThan: Timestamp.fromDate(nextMonday)).get();

        _categories.clear();
        _spentThisWeek = 0;

        for (final doc in spendings.docs) {
          final data = doc.data();

          String category = '';
          if (data.containsKey('category')) {
            category = data['category'];
          }

          double amount = 0;
          if (data.containsKey('amount')) {
            amount = (data['amount']).toDouble();
          }

          _spentThisWeek = _spentThisWeek + amount;

          if (!_categories.containsKey(category)) {
            _categories[category] = _CategorySummary(name: category);
          }

          _categories[category]!.total =
              _categories[category]!.total + amount;
          _categories[category]!.count =
              _categories[category]!.count + 1;

          if (amount > _categories[category]!.max) {
            _categories[category]!.max = amount;
          }
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load dashboard')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  
    @override
    Widget build(BuildContext context) {
      final remaining = (_weeklyGoal - _spentThisWeek).clamp(0, double.infinity);
  
      final progress = _weeklyGoal == 0 ? 0 : (_spentThisWeek / _weeklyGoal).clamp(0, 1);
  
      final weekLabel = (_weekStart == null || _weekEnd == null) ? '' : '${_monthName(_weekStart!.month)} ${_weekStart!.day} - ' '${_weekEnd!.day}';
  
      return Scaffold(
        backgroundColor: _teal,
        body: SafeArea(
          child: _isLoading ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome Back,', style: TextStyle(color: Colors.white, fontSize: 16),),
                        Text(_user?.firstName.toUpperCase() ?? 'NAME', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    Text('Cash: \$${_cash.toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 16),),
                  ],
                ),
              ),
  
              SizedBox(height: 8),

              Center(
                child: SizedBox(
                  width: 190,
                  height: 190,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 170,
                        height: 170,
                        child: CircularProgressIndicator(
                          value: progress.toDouble(),
                          strokeWidth: 10,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('\$${remaining.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700,),),
                          SizedBox(height: 4),
                          Text('to Spend', style: TextStyle(color: Colors.white, fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
  
              SizedBox(height: 5),
              Center(
                child: Text(weekLabel,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 16),

              Expanded(
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _lightTeal,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListView.separated(
                      padding:
                      EdgeInsets.symmetric(vertical: 10),
                      itemCount: _categoryOrder.length,
                      separatorBuilder: (_, __) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final name = _categoryOrder[index];
                        final summary = _categories[name] ?? _CategorySummary(name: name);
  
                        return _CategoryRow(
                          icon: _iconForCategory(name),
                          title: name,
                          total: '\$${summary.total.toStringAsFixed(2)}',
                          max: '\$${summary.max.toStringAsFixed(2)}',
                          avg: '\$${summary.avg.toStringAsFixed(2)}',
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  
    IconData _iconForCategory(String name) {
      switch (name) {
        case 'Shopping':
          return Icons.shopping_bag;
        case 'Groceries':
          return Icons.shopping_cart;
        case 'Gas':
          return Icons.directions_car;
        case 'Eating Out':
          return Icons.restaurant;
        case 'Entertainment':
          return Icons.music_note;
        case 'Subscriptions':
          return Icons.repeat;
        default:
          return Icons.circle;
      }
    }
  
    String _monthName(int month) {
      const list = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',];
      return list[month];
    }
  }
  
  class _CategorySummary {
    final String name;
    double total;
    double max;
    int count;
  
    _CategorySummary({
      required this.name,
      this.total = 0,
      this.max = 0,
      this.count = 0,
    });
  
    double get avg => count == 0 ? 0 : total / count;
  }
  
  class _CategoryRow extends StatelessWidget {
    final IconData icon;
    final String title;
    final String total;
    final String max;
    final String avg;
  
    const _CategoryRow({
      required this.icon,
      required this.title,
      required this.total,
      required this.max,
      required this.avg,
      super.key,
    });
  
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black87),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                  Text('Total: $total', style: TextStyle(fontSize: 14),),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Max: $max', style: TextStyle(fontSize: 14),),
                Text('Avg: $avg', style: TextStyle(fontSize: 14),),
              ],
            ),
          ],
        ),
      );
    }
  }
  
  class Spending extends StatefulWidget {
    const Spending({super.key});
  
    @override
    State<Spending> createState() => _SpendingState();
  }
  
  class _SpendingState extends State<Spending> {
    static const Color _teal = Color(0xFF2EC4B6);
    static const Color _lightTeal = Color(0xFFC8ECEA);
  
    final FirebaseFirestore _db = FirebaseFirestore.instance;
  
    final TextEditingController _amountController =
    TextEditingController(text: "0.00");
  
    final List<String> _categories = const [
      "Shopping",
      "Groceries",
      "Gas",
      "Eating Out",
      "Entertainment",
      "Subscriptions",
    ];
  
    String _selectedCategory = "Shopping";
  
    AppUser? _user;
  
    bool _isLoading = true;
    bool _isSaving = false;
  
    double _cash = 0;
    double _weeklyGoal = 0;
    double _spentThisWeek = 0;
  
    DateTime? _weekStart;
    DateTime? _weekEnd;
  
    @override
    void initState() {
      super.initState();
      _loadSpendingData();
    }
  
    @override
    void dispose() {
      _amountController.dispose();
      super.dispose();
    }

    Future<void> _loadSpendingData() async {
      setState(() {
        _isLoading = true;
      });

      try {
        _user = await SessionManager.instance.getCurrentUser();

        if (_user == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No logged in user found')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }

        final userRef = _db.collection('users').doc(_user!.id);
        final userDoc = await userRef.get();
        final userData = userDoc.data();

        if (userData != null) {
          if (userData.containsKey('cash')) {
            _cash = (userData['cash'] as num).toDouble();
          } else {
            _cash = 0;
          }

          if (userData.containsKey('weeklySpendingGoal')) {
            _weeklyGoal =
                (userData['weeklySpendingGoal'] as num).toDouble();
          } else {
            _weeklyGoal = 0;
          }
        }

        final now = DateTime.now();

        final monday = DateTime(
          now.year,
          now.month,
          now.day - (now.weekday - DateTime.monday),
        );

        final nextMonday = monday.add(Duration(days: 7));

        _weekStart = monday;
        _weekEnd = nextMonday.subtract(Duration(days: 1));

        final spendingSnap = await userRef
            .collection('spendings')
            .where(
          'date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(monday),
        )
            .where(
          'date',
          isLessThan: Timestamp.fromDate(nextMonday),
        )
            .get();

        _spentThisWeek = 0;

        for (final doc in spendingSnap.docs) {
          final data = doc.data();

          double amount = 0;
          if (data.containsKey('amount')) {
            amount = (data['amount'] as num).toDouble();
          }

          _spentThisWeek = _spentThisWeek + amount;
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load spending data')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }

    Future<void> _addSpending() async {
      if (_user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No logged in user found')),
        );
        return;
      }

      final amountText = _amountController.text.trim();
      final amount = double.tryParse(amountText);

      if (amount == null || amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid amount greater than 0')),
        );
        return;
      }

      setState(() {
        _isSaving = true;
      });

      try {
        final userRef = _db.collection('users').doc(_user!.id);

        await _db.runTransaction((transaction) async {
          final userSnap = await transaction.get(userRef);
          final userData = userSnap.data();

          double currentCash = 0;
          if (userData != null && userData.containsKey('cash')) {
            currentCash = (userData['cash'] as num).toDouble();
          }

          if (amount > currentCash) {
            throw Exception('INSUFFICIENT_CASH');
          }

          final newCash = currentCash - amount;

          final spendingRef = userRef.collection('spendings').doc();
          transaction.set(spendingRef, {
            'category': _selectedCategory,
            'amount': amount,
            'date': Timestamp.now(),
          });

          transaction.update(userRef, {
            'cash': newCash,
          });
        });

        _amountController.text = '0.00';
        await _loadSpendingData();

        if (_weeklyGoal > 0) {
          final percentUsed = _spentThisWeek / _weeklyGoal;

          if (percentUsed >= 0.75) {
            if (!mounted) return;

            String message;
            if (_spentThisWeek >= _weeklyGoal) {
              message = 'You have reached your weekly spending limit.';
            } else {
              message =
              'You are nearing your weekly spending limit.\n\n'
                  'You have used ${(percentUsed * 100).toStringAsFixed(0)}% '
                  'of your budget.';
            }

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text('Spending Alert'),
                  content: Text(message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Spending added')),
        );
      } catch (e) {
        if (!mounted) return;

        String errorMessage;
        if (e.toString().contains('INSUFFICIENT_CASH')) {
          errorMessage = 'You do not have enough cash for this spending.';
        } else {
          errorMessage = 'Failed to add spending';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }
  
    @override
    Widget build(BuildContext context) {
      final remaining = (_weeklyGoal - _spentThisWeek).clamp(0, double.infinity);
      double progress = _weeklyGoal == 0 ? 0 : (_spentThisWeek / _weeklyGoal).clamp(0, 1);
  
      final weekLabel = (_weekStart == null || _weekEnd == null) ? '' : '${_monthName(_weekStart!.month)} ${_weekStart!.day} - ''${_weekEnd!.day}';
  
      return Scaffold(
        backgroundColor: _teal,
        body: SafeArea(
          child: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Spending", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,),),
                      Text("Cash: \$${_cash.toStringAsFixed(0)}", style: TextStyle(color: Colors.white, fontSize: 16,),),
                    ],
                  ),
  
                  SizedBox(height: 8),

                  Center(
                    child: SizedBox(
                      width: 190,
                      height: 190,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 170,
                            height: 170,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 10,
                              backgroundColor: Colors.white24,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("\$${remaining.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700,),),
                              SizedBox(height: 4),
                              Text("to Spend", style: TextStyle(color: Colors.white, fontSize: 16,),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
  
                  SizedBox(height: 4),
                  Center(
                    child: Text(weekLabel, style: TextStyle(color: Colors.white, fontSize: 16,),),
                  ),
                  SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _lightTeal,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          24, 24, 24, 24),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Add Spending",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
  
                          Text("Category", style: TextStyle(fontSize: 16),),
                          SizedBox(height: 8),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(15),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCategory,
                                items: _categories.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCategory = value!;
                                  });
                                },
                              ),
                            ),
                          ),
  
                          SizedBox(height: 20),
  
                          Text("Amount", style: TextStyle(fontSize: 16),),
                          SizedBox(height: 8),
                          TextField(
                            controller: _amountController,
                            keyboardType:
                            TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                              hintText: "0.00",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
  
                          SizedBox(height: 20),
  
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed:
                              _isSaving ? null : _addSpending,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                elevation: 4,
                              ),
                              child: Text(_isSaving ? "Saving..." : "Add", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600,),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
  
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      );
    }
  
    String _monthName(int month) {
      const list = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',];
      return list[month];
    }
  }
  
  class Settings extends StatefulWidget {
    const Settings({super.key});
  
    @override
    State<Settings> createState() => _SettingsState();
  }
  
  class _SettingsState extends State<Settings> {
    static const Color _teal = Color(0xFF2EC4B6);
    static const Color _lightTeal = Color(0xFFC8ECEA);
  
    final FirebaseFirestore _db = FirebaseFirestore.instance;
  
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _emailController = TextEditingController();
  
    AppUser? _user;
    bool _isLoading = true;
    bool _isEditing = false;
    bool _isSaving = false;
  
    @override
    void initState() {
      super.initState();
      _loadProfile();
    }
  
    @override
    void dispose() {
      _firstNameController.dispose();
      _lastNameController.dispose();
      _emailController.dispose();
      super.dispose();
    }
  
    Future<void> _loadProfile() async {
      setState(() => _isLoading = true);
  
      try {
        _user = await SessionManager.instance.getCurrentUser();
        if (_user == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            SnackBar(content: Text('No logged in user found.')),
          );
          setState(() => _isLoading = false);
          return;
        }
  
        final doc =
        await _db.collection('users').doc(_user!.id).get();
        final data = doc.data() ?? {};
  
        _firstNameController.text = (data['firstName'] ?? '') as String;
        _lastNameController.text = (data['lastName'] ?? '') as String;
        _emailController.text = (data['email'] ?? '') as String;
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Failed to load profile: $e')),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  
    Future<void> _saveProfile() async {
      if (_user == null) return;
  
      final first = _firstNameController.text.trim();
      final last = _lastNameController.text.trim();
      final email = _emailController.text.trim();
  
      if (first.isEmpty || last.isEmpty || email.isEmpty) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Please fill in all fields.'),),
        );
        return;
      }
  
      setState(() => _isSaving = true);
  
      try {
        final userRef = _db.collection('users').doc(_user!.id);
  
        await userRef.update({
          'firstName': first,
          'lastName': last,
          'email': email,
        });
  
        if (!mounted) return;
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Profile updated.')),
        );
  
        setState(() => _isEditing = false);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      } finally {
        if (mounted) setState(() => _isSaving = false);
      }
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: _teal,
        body: SafeArea(
          child: _isLoading ? const Center(child: CircularProgressIndicator(color: Colors.white),)
              : Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Settings", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,),),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _lightTeal,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          24, 24, 24, 24),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          _buildFieldRow(
                            label: 'First Name:',
                            controller: _firstNameController,
                          ),
                          SizedBox(height: 12),
                          _buildFieldRow(
                            label: 'Last Name:',
                            controller: _lastNameController,
                          ),
                          SizedBox(height: 12),
                          _buildFieldRow(
                            label: 'Email:',
                            controller: _emailController,
                          ),
                          SizedBox(height: 24),

                          Row(
                            children: [
                              SizedBox(
                                width: 140,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: _isSaving ? null : () {
                                    if (_isEditing) {
                                      _saveProfile();
                                    } else {
                                      setState(() {
                                        _isEditing = true;
                                      });
                                    }
                                  },
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor: _teal,
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          15),
                                    ),
                                    elevation: 3,
                                  ),
                                  child: Text(
                                    _isEditing ? (_isSaving ? 'Saving...' : 'Save') : 'Edit Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              if (_isEditing)
                                TextButton(
                                  onPressed: _isSaving ? null : () {
                                    setState(() {
                                      _isEditing = false;
                                    });
                                  },
                                  child: Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildFieldRow({
      required String label,
      required TextEditingController controller,
    }) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontFamily: 'Inter',),),
          SizedBox(width: 8),
          Expanded(
            child: _isEditing ? TextField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            )
                : Text(controller.text, style: TextStyle(fontSize: 16, fontFamily: 'Inter',),),
          ),
        ],
      );
    }
  }
  
  class Invest extends StatefulWidget {
    const Invest({super.key});
  
    @override
    State<Invest> createState() => _InvestState();
  }
  
  class _InvestState extends State<Invest> {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    AppUser? _user;
    double _cash = 0;
    double _yearlyGoal = 0;
    double _totalInvested = 0;
    int _selectedTab = 0;
    List<StockModel>? _stockModel = [];
  
    @override
    void initState() {
      super.initState();
      _loadUserInvestData();
      _getStocks();
    }

    Future<void> _loadUserInvestData() async {
      _user = await SessionManager.instance.getCurrentUser();

      if (_user == null) {
        return;
      }

      final doc = await _db.collection('users').doc(_user!.id).get();
      final data = doc.data();
      double cash = 0;
      double invested = 0;
      double yearlyGoal = 0;

      if (data != null) {
        if (data.containsKey('cash')) {
          cash = (data['cash'] as num).toDouble();
        }

        if (data.containsKey('totalInvested')) {
          invested = (data['totalInvested'] as num).toDouble();
        }

        if (data.containsKey('yearlyInvestmentGoal')) {
          yearlyGoal =
              (data['yearlyInvestmentGoal'] as num).toDouble();
        }
      }
      setState(() {
        _cash = cash;
        _totalInvested = invested;
        _yearlyGoal = yearlyGoal;
      });
    }
  
    void _getStocks() async {
      print("Starting _getStocks()");
      final api = ApiService();
  
      List<String> symbols = ["AAPL", "GOOG", "NVDA", "AMD", "MSFT"];
  
      List<StockModel> temp = [];
      for (String symbol in symbols) {
        print(" Fetching: $symbol");
  
        final stock = await api.getStocks(symbol);
        if (stock != null) temp.add(stock);
      }
      setState(() {
        _stockModel = temp;
      });
    }
  
    void _showBuyDialog(BuildContext context, Stock stock) {
      final TextEditingController sharesController =
      TextEditingController(text: '1');
  
      showDialog(
        context: context,
        builder: (_) {
          int shares = 1;
  
          return StatefulBuilder(
            builder: (context, setDialogState) {
              final total = shares * stock.price;
  
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Image.network(stock.logoUrl, height: 40),
                        SizedBox(width: 12),
                        Text(
                          '${stock.name} \$${stock.price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
  
                    SizedBox(height: 20),
  
                    Text('# of Shares'),
                    SizedBox(height: 8),
  
                    TextField(
                      controller: sharesController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setDialogState(() {
                          shares = int.tryParse(value) ?? 1;
                          if (shares < 1) shares = 1;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
  
                    SizedBox(height: 12),
  
                    Text('Amount: \$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),
  
                    SizedBox(height: 20),
  
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _placeBuyOrder(
                          stock,
                          shares.toString(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Place Order', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  
    void _showSellDialog(Stock stock, double maxShares) {
      final TextEditingController controller = TextEditingController(text: '1');
  
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Image.network(stock.logoUrl, height: 40),
                  SizedBox(width: 12),
                  Text(stock.name, style: TextStyle(fontSize: 18)),
                ],
              ),
  
              SizedBox(height: 20),
  
              Text('Max shares: ${maxShares.toStringAsFixed(2)}'),
              SizedBox(height: 8),
  
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
  
              SizedBox(height: 20),
  
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _placeSellOrder(stock, controller.text);
                },
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,),
                child: Text('Place Sell Order', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      );
    }
    Future<void> _placeSellOrder(Stock stock, String sharesText) async {
      if (_user == null) {
        return;
      }

      final sellShares = double.tryParse(sharesText);

      if (sellShares == null || sellShares <= 0) {
        return;
      }

      final userRef = _db.collection('users').doc(_user!.id);

      await _db.runTransaction((transaction) async {
        final snap = await transaction.get(userRef);
        final data = snap.data();

        double cash = 0;
        double invested = 0;
        Map<String, dynamic> holdings = {};

        if (data != null) {
          if (data.containsKey('cash')) {
            cash = (data['cash'] as num).toDouble();
          }

          if (data.containsKey('totalInvested')) {
            invested = (data['totalInvested'] as num).toDouble();
          }

          if (data.containsKey('holdings')) {
            holdings = Map<String, dynamic>.from(data['holdings']);
          }
        }

        if (!holdings.containsKey(stock.name)) {
          return;
        }

        final holding = holdings[stock.name];

        final ownedShares = (holding['shares'] as num).toDouble();
        final avgPrice = (holding['avgPrice'] as num).toDouble();

        if (sellShares > ownedShares) {
          return;
        }

        final sellAmount = sellShares * avgPrice;
        final remainingShares = ownedShares - sellShares;

        if (remainingShares <= 0) {
          holdings.remove(stock.name);
        } else {
          holding['shares'] = remainingShares;
          holding['totalValue'] = remainingShares * avgPrice;
        }

        double newInvested = invested - sellAmount;
        if (newInvested < 0) {
          newInvested = 0;
        }

        transaction.update(userRef, {
          'cash': cash + sellAmount,
          'totalInvested': newInvested,
          'holdings': holdings,
        });
      });

      await _loadUserInvestData();
    }

    Future<void> _placeBuyOrder(Stock stock, String sharesText) async {
      if (_user == null) {
        return;
      }

      final parsedShares = int.tryParse(sharesText);
      if (parsedShares == null || parsedShares <= 0) {
        return;
      }

      final totalCost = parsedShares * stock.price;

      if (_cash < totalCost) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not enough cash')),
        );
        return;
      }

      final userRef = _db.collection('users').doc(_user!.id);

      await _db.runTransaction((transaction) async {
        final snap = await transaction.get(userRef);
        final data = snap.data();

        double currentCash = 0;
        double currentInvested = 0;
        Map<String, dynamic> holdings = {};

        if (data != null) {
          if (data.containsKey('cash')) {
            currentCash = (data['cash'] as num).toDouble();
          }

          if (data.containsKey('totalInvested')) {
            currentInvested = (data['totalInvested'] as num).toDouble();
          }

          if (data.containsKey('holdings')) {
            holdings = Map<String, dynamic>.from(data['holdings']);
          }
        }

        double newShares = parsedShares.toDouble();
        double newAvgPrice = stock.price;

        if (holdings.containsKey(stock.name)) {
          final existing = holdings[stock.name];

          final oldShares = (existing['shares'] as num).toDouble();
          final oldAvgPrice = (existing['avgPrice'] as num).toDouble();

          newAvgPrice =
              ((oldShares * oldAvgPrice) + totalCost) /
                  (oldShares + newShares);

          newShares = newShares + oldShares;
        }

        holdings[stock.name] = {
          'symbol': stock.name,
          'logoUrl': stock.logoUrl,
          'shares': newShares,
          'avgPrice': newAvgPrice,
          'totalValue': newShares * newAvgPrice,
        };

        transaction.update(userRef, {
          'cash': currentCash - totalCost,
          'totalInvested': currentInvested + totalCost,
          'holdings': holdings,
        });
      });

      await _loadUserInvestData();
    }
  
    Widget _buildInvestList() {
      if (_stockModel == null || _stockModel!.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
  
      return ListView.separated(
        itemCount: _stockModel!.length,
        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.black12),
        itemBuilder: (context, index) {
          final stock = _stockModel![index];
  
          final uiStock = Stock(
            name: stock.symbol,
            price: stock.price,
            logoUrl: stock.image,
          );
  
          return _StockRow(
            stock: uiStock,
            onBuyPressed: () {
              _showBuyDialog(context, uiStock);
            },
          );
        },
      );
    }
  
    Widget _buildHoldings() {
      return StreamBuilder<DocumentSnapshot>(
        stream: _db.collection('users').doc(_user!.id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
  
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final holdings =
          Map<String, dynamic>.from(data['holdings'] ?? {});
  
          if (holdings.isEmpty) {
            return Center(child: Text('No holdings yet'));
          }
  
          return ListView(
            children: holdings.values.map((h) {
              return _HoldingRow(
                symbol: h['symbol'],
                logoUrl: h['logoUrl'],
                shares: (h['shares']).toDouble(),
                avgPrice: (h['avgPrice']).toDouble(),
                totalValue: (h['totalValue']).toDouble(),
                onSellPressed: () {
                  _showSellDialog(
                    Stock(
                      name: h['symbol'],
                      price: (h['avgPrice']).toDouble(),
                      logoUrl: h['logoUrl'],
                    ),
                    (h['shares']).toDouble(),
                  );
                },
              );
            }).toList(),
          );
        },
      );
    }
  
  
    @override
    Widget build(BuildContext context) {
      double progress = (_yearlyGoal <= 0) ? 0 : (_totalInvested / _yearlyGoal).clamp(0, 1);
  
      const Color _teal = Color(0xFF2EC4B6);
      const Color _lightTeal = Color(0xFFC8ECEA);
      return Scaffold(
        backgroundColor: _teal,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Investments',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Cash: \$${_cash.toStringAsFixed(0)}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
  
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 190,
                    height: 190,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 170,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 10,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${_totalInvested.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Invested',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
  
                SizedBox(height: 10),
  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButton(label: 'Invest', index: 0),
                    SizedBox(width: 10),
                    _buildTabButton(label: 'Holdings', index: 1),
                  ],
                ),
  
                SizedBox(height: 10),
  
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _lightTeal,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: _selectedTab == 0 ? _buildInvestList() : _buildHoldings(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  
    Widget _buildTabButton({required String label, required int index}) {
      final bool isSelected = _selectedTab == index;
      const Color _lightTeal = Color(0xFFC8ECEA);
  
      return Expanded(
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedTab = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? Colors.white : _lightTeal,
              foregroundColor: isSelected ? Colors.black : Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: isSelected ? 3 : 0,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
  }
  
  class _StockRow extends StatelessWidget {
    final Stock stock;
    final VoidCallback onBuyPressed;
  
    const _StockRow({
      super.key,
      required this.stock,
      required this.onBuyPressed,
    });
  
    @override
    Widget build(BuildContext context) {
      return Container(
        padding:
        EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                stock.logoUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                Icon(Icons.show_chart, size: 24),
              ),
            ),
  
            SizedBox(width: 10),
  
            Expanded(
              child: Text(
                '${stock.name} \$${stock.price.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
  
            SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: onBuyPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Buy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
  
  class _HoldingRow extends StatelessWidget {
    final String symbol;
    final String logoUrl;
    final double shares;
    final double avgPrice;
    final double totalValue;
    final VoidCallback onSellPressed;
  
    const _HoldingRow({
      required this.symbol,
      required this.logoUrl,
      required this.shares,
      required this.avgPrice,
      required this.totalValue,
      required this.onSellPressed,
      super.key,
    });
  
    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                logoUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                Icon(Icons.show_chart),
              ),
            ),
  
            SizedBox(width: 10),
  
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(symbol, style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('${shares.toStringAsFixed(2)} shares @ \$${avgPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
  
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${totalValue.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(onPressed: onSellPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text('Sell', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
  
  class Budget extends StatefulWidget {
    const Budget({super.key});
  
    @override
    State<Budget> createState() => _BudgetState();
  }
  
  class _BudgetState extends State<Budget> {
    final TextEditingController _salaryController = TextEditingController();
    final TextEditingController _weeklySpendingController =
    TextEditingController();
    final TextEditingController _yearlyGoalController = TextEditingController();
  
    bool _isLoading = true;
    bool _isSaving = false;
    bool _isEditing = false;
  
    double? _salary;
    double? _weeklySpending;
    double? _yearlyGoal;
    double? _cash;
  
    late FirebaseFirestore _db;
    AppUser? _currentUser;
  
    @override
    void initState() {
      super.initState();
      _db = FirebaseFirestore.instance;
      _loadBudget();
    }
  
    @override
    void dispose() {
      _salaryController.dispose();
      _weeklySpendingController.dispose();
      _yearlyGoalController.dispose();
      super.dispose();
    }

    Future<void> _loadBudget() async {
      setState(() {
        _isLoading = true;
      });

      try {
        _currentUser = await SessionManager.instance.getCurrentUser();

        if (_currentUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No logged in user found')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }

        final doc =
        await _db.collection('users').doc(_currentUser!.id).get();
        final data = doc.data();

        _salary = null;
        _weeklySpending = null;
        _yearlyGoal = null;
        _cash = null;

        if (data != null) {
          if (data.containsKey('salary')) {
            _salary = (data['salary']).toDouble();
          }

          if (data.containsKey('weeklySpendingGoal')) {
            _weeklySpending =
                (data['weeklySpendingGoal']).toDouble();
          }

          if (data.containsKey('yearlyInvestmentGoal')) {
            _yearlyGoal =
                (data['yearlyInvestmentGoal']).toDouble();
          }

          if (data.containsKey('cash')) {
            _cash = (data['cash']).toDouble();
          }
        }

        if (_salary != null) {
          _salaryController.text = _salary!.toStringAsFixed(2);
        } else {
          _salaryController.text = '';
        }

        if (_weeklySpending != null) {
          _weeklySpendingController.text =
              _weeklySpending!.toStringAsFixed(2);
        } else {
          _weeklySpendingController.text = '';
        }

        if (_yearlyGoal != null) {
          _yearlyGoalController.text =
              _yearlyGoal!.toStringAsFixed(2);
        } else {
          _yearlyGoalController.text = '';
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load budget')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  
    Future<void> _saveBudget() async {
      if (_currentUser == null) return;
  
      final salary = double.tryParse(_salaryController.text.trim());
      final weekly = double.tryParse(_weeklySpendingController.text.trim());
      final yearly = double.tryParse(_yearlyGoalController.text.trim());
  
      if (salary == null || weekly == null || yearly == null) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Please enter valid numbers.')),
        );
        return;
      }
  
      setState(() => _isSaving = true);
  
      try {
        await _db.collection('users').doc(_currentUser!.id).update({
          'salary': salary,
          'weeklySpendingGoal': weekly,
          'yearlyInvestmentGoal': yearly,
        });

        _salary = salary;
        _weeklySpending = weekly;
        _yearlyGoal = yearly;
  
        setState(() {
          _isEditing = false;
        });
  
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Budget updated successfully.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Failed to update budget: $e')),
        );
      } finally {
        if (mounted) {
          setState(() => _isSaving = false);
        }
      }
    }
  
    @override
    Widget build(BuildContext context) {
      const Color _teal = Color(0xFF2EC4B6);
      const Color _lightTeal = Color(0xFFC8ECEA);
  
      return Scaffold(
        backgroundColor: _teal,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Budget', style: TextStyle(color: Colors.white, fontSize: 18,),),
                    Text('Cash: \$${_cash?.toStringAsFixed(0) ?? '0'}', style: TextStyle(color: Colors.white, fontSize: 16,),),
                  ],
                ),
  
                SizedBox(height: 12),
  
                Text('WealthWay', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600,),),
  
                SizedBox(height: 16),
  
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _lightTeal,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: _isLoading ? Center(child: CircularProgressIndicator()) : Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _section(
                            label: 'Salary',
                            value: _salary,
                            controller: _salaryController,
                            isEditing: _isEditing,
                          ),
                          SizedBox(height: 24),
                          _section(
                            label: 'Weekly Spending',
                            value: _weeklySpending,
                            controller: _weeklySpendingController,
                            isEditing: _isEditing,
                          ),
                          SizedBox(height: 24),
                          _section(
                            label: 'Yearly Investment Goal',
                            value: _yearlyGoal,
                            controller: _yearlyGoalController,
                            isEditing: _isEditing,
                          ),
                          Spacer(),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isSaving ? null : () {
                                if (_isEditing) {
                                  _saveBudget();
                                } else {
                                  setState(() => _isEditing = true);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(_isEditing ? 'Save Changes' : 'Edit Budget', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600,),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  
    Widget _section({
      required String label,
      required double? value,
      required TextEditingController controller,
      required bool isEditing,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 18, fontFamily: 'Inter',),),
          SizedBox(height: 8),
          if (isEditing)
            _roundedField(controller: controller)
          else
            _displayBox(
              value != null ? value.toStringAsFixed(2) : 'Not set',
            ),
        ],
      );
    }
  
    Widget _roundedField({required TextEditingController controller}) {
      return TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
    }
  
    Widget _displayBox(String text) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(fontSize: 16, fontFamily: 'Inter',),),
      );
    }
  }
  
  
  class AppUser {
    final String id;
    final String firstName;
    final String lastName;
    final String email;
  
    AppUser({
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
    });
  
    Map<String, dynamic> toMap({required String password}) {
      return {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      };
    }
  
    factory AppUser.fromMap(String id, Map<String, dynamic> map) {
      return AppUser(
        id: id,
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        email: map['email'] ?? '',
      );
    }
  }
  
  class SessionManager {
    SessionManager._();
    static final instance = SessionManager._();
  
    static const _keyUserId = 'userId';
    static const _keyFirstName = 'firstName';
    static const _keyLastName = 'lastName';
    static const _keyEmail = 'email';
  
    Future<void> saveCurrentUser(AppUser user) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUserId, user.id);
      await prefs.setString(_keyFirstName, user.firstName);
      await prefs.setString(_keyLastName, user.lastName);
      await prefs.setString(_keyEmail, user.email);
    }
  
    Future<AppUser?> getCurrentUser() async {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString(_keyUserId);
      if (id == null) return null;
  
      return AppUser(
        id: id,
        firstName: prefs.getString(_keyFirstName) ?? '',
        lastName: prefs.getString(_keyLastName) ?? '',
        email: prefs.getString(_keyEmail) ?? '',
      );
    }
  
    Future<void> clearSession() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyUserId);
      await prefs.remove(_keyFirstName);
      await prefs.remove(_keyLastName);
      await prefs.remove(_keyEmail);
    }
  }
  
  class Stock {
    final String name;
    final double price;
    final String logoUrl;
  
    Stock({
      required this.name,
      required this.price,
      required this.logoUrl,
    });
  }
  
  class AuthService {
    AuthService._();
    static final instance = AuthService._();
  
    final FirebaseFirestore _db = FirebaseFirestore.instance;
  
    CollectionReference get _usersCol => _db.collection('users');
  
    Future<String?> registerUser({
      required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword,
    }) async {

      if (firstName.trim().isEmpty) {
        return 'First name is required.';
      }
      if (lastName.trim().isEmpty) {
        return 'Last name is required.';
      }
      if (!EmailValidator.validate(email.trim())) {
        return 'Please enter a valid email address.';
      }
      if (password.length < 8) {
        return 'Password must be at least 8 characters.';
      }
      if (password != confirmPassword) {
        return 'Passwords do not match.';
      }
  
      try {
        final existing = await _usersCol
            .where('email', isEqualTo: email.trim())
            .limit(1)
            .get();
  
        if (existing.docs.isNotEmpty) {
          return 'An account with this email already exists.';
        }
  
        final docRef = await _usersCol.add({
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
          'email': email.trim(),
          'password': password,
          'salary': 0,
          'weeklySpendingGoal': 0,
          'yearlyInvestmentGoal': 0,
          'cash': 0,
          'lastCashTopUp': null,
          'createdAt': FieldValue.serverTimestamp(),
        });
  
        final user = AppUser(
          id: docRef.id,
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          email: email.trim(),
        );
  
        await SessionManager.instance.saveCurrentUser(user);
  
        return null;
      } catch (e) {
        return 'Registration failed: $e';
      }
    }
  
    Future<String?> loginUser({
      required String email,
      required String password,
    }) async {
      if (!EmailValidator.validate(email.trim())) {
        return 'Please enter a valid email address.';
      }
      if (password.isEmpty) {
        return 'Password is required.';
      }
  
      try {
        final snapshot = await _usersCol
            .where('email', isEqualTo: email.trim())
            .where('password', isEqualTo: password)
            .limit(1)
            .get();
  
        if (snapshot.docs.isEmpty) {
          return 'Invalid email or password.';
        }
  
        final doc = snapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>;
        final user = AppUser.fromMap(doc.id, data);
  
        await SessionManager.instance.saveCurrentUser(user);
  
        return null;
      } catch (e) {
        return 'Login failed: $e';
      }
    }
  
    Future<String?> resetPassword({
      required String email,
      required String newPassword,
      required String confirmPassword,
    }) async {
      if (!EmailValidator.validate(email.trim())) {
        return 'Please enter a valid email address.';
      }
      if (newPassword.length < 8) {
        return 'Password must be at least 8 characters.';
      }
      if (newPassword != confirmPassword) {
        return 'Passwords do not match.';
      }
  
      try {
        final snapshot = await _usersCol
            .where('email', isEqualTo: email.trim())
            .limit(1)
            .get();
  
        if (snapshot.docs.isEmpty) {
          return 'No account found with that email.';
        }
  
        final doc = snapshot.docs.first;
        await _usersCol.doc(doc.id).update({
          'password': newPassword,
        });
  
        return null;
      } catch (e) {
        return 'Could not reset password: $e';
      }
    }
  
    Future<void> signOut() async {
      await SessionManager.instance.clearSession();
    }
  }