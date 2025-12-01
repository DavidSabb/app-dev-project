import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:path/path.dart';
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
    print('fireabase apps: ${Firebase.apps.length}');
    const Color _teal = Color(0xFF2EC4B6);
    const Color _lightTeal = Color(0xFFC8ECEA);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: _teal,
        child: Column(
          children: [
            const SizedBox(height: 150),

            const Text(
              'WealthWay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_balance,
                size: 50,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _lightTeal,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      const Text(
                        'Small Steps.\nBig Savings.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'Your journey to financial freedom starts here. '
                            'Secure your savings, set your goals, and take control '
                            'of your future today.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF5E5E5E),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 30),

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
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

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
                          child: const Text(
                            'Register',
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //return button
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 50,),
                  onPressed: () => Navigator.pop(context),
                ),

                const SizedBox(height: 16),

                const Center(
                  child: Text(
                    'Join Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    'Create a Free Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _lightTeal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Registration',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'Your Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: _roundedField(
                                hint: 'First Name',
                                controller: _firstNameController,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _roundedField(
                                hint: 'Last Name',
                                controller: _lastNameController,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),

                        _roundedField(
                          hint: 'Your Email Address',
                          suffixIcon: const Icon(Icons.mail_outline),
                          controller: _emailController,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),

                        _roundedField(
                          hint: '8 char min',
                          obscure: true,
                          controller: _passwordController,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),

                        _roundedField(
                          hint: 'Confirm Password',
                          obscure: true,
                          controller: _confirmPasswordController,
                        ),

                        const SizedBox(height: 24),

                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const Home()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 4,
                                shadowColor: Colors.black45,
                              ),
                              child: const Text(
                                'Register',
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
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),

                const SizedBox(height: 16),

                const Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: lightTeal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Login Account',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),

                        _roundedField(
                          hint: 'Your Email Address',
                          suffixIcon: const Icon(Icons.mail_outline),
                          controller: _loginEmailController,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),

                        _roundedField(
                          hint: '8 char min',
                          obscure: true,
                          controller: _loginPasswordController,
                        ),

                        const SizedBox(height: 8),

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
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Inter',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

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
                              shadowColor: Colors.black45,
                            ),
                            child: const Text(
                              'Login Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
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
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Create New Account',
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

  // same helper used in registration
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
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
  final List<Widget> _pages = const [
    Budget(),
    Invest(),
    Dashboard(),
    Spending(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 30,
        onTap: _onItemTapped,
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

  // category -> summary
  final Map<String, _CategorySummary> _categories = {};

  // fixed order for display
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
    setState(() => _isLoading = true);

    try {
      // 1. Current user from SharedPreferences
      _user = await SessionManager.instance.getCurrentUser();
      if (_user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('No logged in user found.')),
        );
        setState(() => _isLoading = false);
        return;
      }

      // 2. User document (cash + weekly goal + lastCashTopUp)
      final userRef = _db.collection('users').doc(_user!.id);
      final userDoc = await userRef.get();
      final userData = userDoc.data() ?? {};

      _cash = (userData['cash'] as num?)?.toDouble() ?? 0;
      _weeklyGoal =
          (userData['weeklySpendingGoal'] as num?)?.toDouble() ?? 0;
      final lastTopUpTs = userData['lastCashTopUp'] as Timestamp?;
      final now = DateTime.now();

      // 3. Weekly cash top-up by weeklySpendingGoal
      if (_weeklyGoal > 0) {
        if (lastTopUpTs == null) {
          // First time: give one week of budget
          _cash += _weeklyGoal;
          await userRef.update({
            'cash': _cash,
            'lastCashTopUp': Timestamp.fromDate(now),
          });
        } else {
          final lastTopUp = lastTopUpTs.toDate();
          final days = now.difference(lastTopUp).inDays;
          final weeksPassed = days ~/ 7;

          if (weeksPassed > 0) {
            final added = _weeklyGoal * weeksPassed;
            _cash += added;

            await userRef.update({
              'cash': _cash,
              'lastCashTopUp': Timestamp.fromDate(now),
            });
          }
        }
      }

      // 4. Compute current week (Mon → Sun)
      final monday =
      now.subtract(Duration(days: now.weekday - DateTime.monday));
      final nextMonday = monday.add(const Duration(days: 7));
      _weekStart = monday;
      _weekEnd = nextMonday.subtract(const Duration(days: 1));

      // 5. Query this week's spendings
      final spendingSnap = await userRef
          .collection('spendings')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(monday))
          .where('date', isLessThan: Timestamp.fromDate(nextMonday))
          .get();

      _categories.clear();
      _spentThisWeek = 0;

      for (final doc in spendingSnap.docs) {
        final data = doc.data();
        final category = (data['category'] ?? '') as String;
        final amount = (data['amount'] as num?)?.toDouble() ?? 0;

        _spentThisWeek += amount;

        final summary = _categories.putIfAbsent(
          category,
              () => _CategorySummary(name: category),
        );

        summary.total += amount;
        summary.count += 1;
        if (amount > summary.max) summary.max = amount;
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Failed to load dashboard: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = (_weeklyGoal - _spentThisWeek).clamp(0, double.infinity);
    final progress =
    _weeklyGoal == 0 ? 0.0 : (_spentThisWeek / _weeklyGoal).clamp(0, 1);

    final weekLabel = (_weekStart == null || _weekEnd == null)
        ? ''
        : '${_monthName(_weekStart!.month)} ${_weekStart!.day} - '
        '${_weekEnd!.day}';

    return Scaffold(
      backgroundColor: _teal,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Welcome / Cash
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back,',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        _user?.firstName.toUpperCase() ?? 'NAME',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Cash: \$${_cash.toStringAsFixed(0)}',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Circle: remaining to spend
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
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '\$${remaining.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'to Spend',
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 4),
            Center(
              child: Text(
                weekLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category list
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _lightTeal,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListView.separated(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _categoryOrder.length,
                    separatorBuilder: (_, __) =>
                    const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final name = _categoryOrder[index];
                      final summary =
                          _categories[name] ?? _CategorySummary(name: name);

                      return _CategoryRow(
                        icon: _iconForCategory(name),
                        title: name,
                        total:
                        '\$${summary.total.toStringAsFixed(2)}',
                        max: '\$${summary.max.toStringAsFixed(2)}',
                        avg:
                        '\$${summary.avg.toStringAsFixed(2)}',
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
    const names = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[month];
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
      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Total: $total',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Max: $max', style: const TextStyle(fontSize: 14)),
              Text('Avg: $avg', style: const TextStyle(fontSize: 14)),
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
    setState(() => _isLoading = true);

    try {
      // 1. Current user
      _user = await SessionManager.instance.getCurrentUser();
      if (_user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('No logged in user found.')),
        );
        setState(() => _isLoading = false);
        return;
      }

      final userRef = _db.collection('users').doc(_user!.id);
      final userDoc = await userRef.get();
      final userData = userDoc.data() ?? {};

      _cash = (userData['cash'] as num?)?.toDouble() ?? 0;
      _weeklyGoal =
          (userData['weeklySpendingGoal'] as num?)?.toDouble() ?? 0;

      // 2. Compute this week
      final now = DateTime.now();
      final monday =
      now.subtract(Duration(days: now.weekday - DateTime.monday));
      final nextMonday = monday.add(const Duration(days: 7));

      _weekStart = monday;
      _weekEnd = nextMonday.subtract(const Duration(days: 1));

      // 3. Query this week's spendings
      final spendingSnap = await userRef
          .collection('spendings')
          .where('date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(monday))
          .where('date',
          isLessThan: Timestamp.fromDate(nextMonday))
          .get();

      _spentThisWeek = 0;
      for (final doc in spendingSnap.docs) {
        final data = doc.data();
        final amount = (data['amount'] as num?)?.toDouble() ?? 0;
        _spentThisWeek += amount;
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Failed to load spending data: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _addSpending() async {
    if (_user == null) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('No logged in user found.')),
      );
      return;
    }

    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount > 0.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final userRef = _db.collection('users').doc(_user!.id);

      await _db.runTransaction((tx) async {
        final userSnap = await tx.get(userRef);
        final userData =
            userSnap.data() as Map<String, dynamic>? ?? {};

        final currentCash =
            (userData['cash'] as num?)?.toDouble() ?? 0;
        final newCash = currentCash - amount;

        // 1) add spending
        final spendingRef = userRef.collection('spendings').doc();
        tx.set(spendingRef, {
          'category': _selectedCategory,
          'amount': amount,
          'date': Timestamp.now(),
        });

        // 2) update cash
        tx.update(userRef, {'cash': newCash});
      });

      // reset field + reload
      _amountController.text = '0.00';
      await _loadSpendingData();

      if (!mounted) return;
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Spending added.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Failed to add spending: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining =
    (_weeklyGoal - _spentThisWeek).clamp(0, double.infinity);
    final progress = _weeklyGoal == 0
        ? 0.0
        : (_spentThisWeek / _weeklyGoal).clamp(0, 1).toDouble();

    final weekLabel = (_weekStart == null || _weekEnd == null)
        ? ''
        : '${_monthName(_weekStart!.month)} ${_weekStart!.day} - '
        '${_weekEnd!.day}';

    return Scaffold(
      backgroundColor: _teal,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Spending",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Cash: \$${_cash.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Circle
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
                            const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "\$${remaining.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "to Spend",
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

                const SizedBox(height: 4),
                Center(
                  child: Text(
                    weekLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _lightTeal,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        24, 24, 24, 24),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Add Spending",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          "Category",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 12),
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

                        const SizedBox(height: 20),

                        const Text(
                          "Amount",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
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

                        const SizedBox(height: 20),

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
                            child: Text(
                              _isSaving ? "Saving..." : "Add",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[month];
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
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _lightTeal,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        24, 24, 24, 24),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        _buildFieldRow(
                          label: 'First Name:',
                          controller: _firstNameController,
                        ),
                        const SizedBox(height: 12),
                        _buildFieldRow(
                          label: 'Last Name:',
                          controller: _lastNameController,
                        ),
                        const SizedBox(height: 12),
                        _buildFieldRow(
                          label: 'Email:',
                          controller: _emailController,
                        ),
                        const SizedBox(height: 24),

                        // Buttons
                        Row(
                          children: [
                            SizedBox(
                              width: 140,
                              height: 44,
                              child: ElevatedButton(
                                onPressed: _isSaving
                                    ? null
                                    : () {
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
                                  _isEditing
                                      ? (_isSaving
                                      ? 'Saving...'
                                      : 'Save')
                                      : 'Edit Profile',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (_isEditing)
                              TextButton(
                                onPressed: _isSaving
                                    ? null
                                    : () {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper: shows either Text or TextField depending on _isEditing
  Widget _buildFieldRow({
    required String label,
    required TextEditingController controller,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _isEditing
              ? TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 8),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          )
              : Text(
            controller.text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
            ),
          ),
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
  int _selectedTab = 0; // 0 = Invest, 1 = Holdings
  List<StockModel>? _stockModel = [];

  @override
  void initState() {
    super.initState();
    _getStocks();
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

  @override
  Widget build(BuildContext context) {
    const Color _teal = Color(0xFF2EC4B6);
    const Color _lightTeal = Color(0xFFC8ECEA);
    return Scaffold(
      backgroundColor: _teal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Investments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Cash: \$513',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

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
                          value: 0.8,
                          strokeWidth: 10,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$7313.32',
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

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton(label: 'Invest', index: 0),
                  const SizedBox(width: 12),
                  _buildTabButton(label: 'Holdings', index: 1),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _lightTeal,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: _stockModel == null || _stockModel!.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                      itemCount: _stockModel!.length,
                      separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Colors.black12),
                      itemBuilder: (context, index) {
                        final stock = _stockModel![index];
                        return _StockRow(
                          stock: Stock(
                            name: stock.symbol,
                            price: stock.price,
                            logoUrl: stock.image,
                          ),
                          onBuyPressed: () {
                            // buy logic here
                          },
                        );
                      },
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

  Widget _buildTabButton({required String label, required int index}) {
    final bool isSelected = _selectedTab == index;
    const Color _lightTeal = Color(0xFFC8ECEA);

    return Expanded(
      child: SizedBox(
        height: 42,
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
            style: const TextStyle(
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
      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
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
              const Icon(Icons.show_chart, size: 24),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              '${stock.name} \$${stock.price.toStringAsFixed(0)}',
              style: const TextStyle(
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
                backgroundColor: const Color(0xFF2EC4B6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 2,
              ),
              child: const Text(
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
    setState(() => _isLoading = true);

    try {
      _currentUser = await SessionManager.instance.getCurrentUser();
      if (_currentUser == null) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('No logged in user found.')),
        );
        setState(() => _isLoading = false);
        return;
      }

      final doc = await _db.collection('users').doc(_currentUser!.id).get();
      final data = doc.data() ?? {};

      _salary = (data['salary'] as num?)?.toDouble();
      _weeklySpending = (data['weeklySpendingGoal'] as num?)?.toDouble();
      _yearlyGoal = (data['yearlyInvestmentGoal'] as num?)?.toDouble();
      _cash = (data['cash'] as num?)?.toDouble();

      // Prefill controllers for edit mode
      _salaryController.text =
      _salary != null ? _salary!.toStringAsFixed(2) : '';
      _weeklySpendingController.text =
      _weeklySpending != null ? _weeklySpending!.toStringAsFixed(2) : '';
      _yearlyGoalController.text =
      _yearlyGoal != null ? _yearlyGoal!.toStringAsFixed(2) : '';
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Failed to load budget: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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

      // Update local values
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Budget / Cash
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Budget',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Cash: \$${_cash?.toStringAsFixed(0) ?? '0'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Text(
                'WealthWay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _lightTeal,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _section(
                          label: 'Salary',
                          value: _salary,
                          controller: _salaryController,
                          isEditing: _isEditing,
                        ),
                        const SizedBox(height: 24),
                        _section(
                          label: 'Weekly Spending',
                          value: _weeklySpending,
                          controller: _weeklySpendingController,
                          isEditing: _isEditing,
                        ),
                        const SizedBox(height: 24),
                        _section(
                          label: 'Yearly Investment Goal',
                          value: _yearlyGoal,
                          controller: _yearlyGoalController,
                          isEditing: _isEditing,
                        ),
                        const Spacer(),

                        // Edit / Save button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isSaving
                                ? null
                                : () {
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
                            child: Text(
                              _isEditing ? 'Save Changes' : 'Edit Budget',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
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
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
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
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _displayBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Inter',
        ),
      ),
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
    //validation
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
      // Check if email already used
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
        'lastCashUpdate': null,
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