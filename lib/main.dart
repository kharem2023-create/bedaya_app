import 'package:flutter/material.dart';

void main() {
  runApp(const BedayaApp());
}

class BedayaApp extends StatelessWidget {
  const BedayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بداية',
      theme: ThemeData(
        primaryColor: const Color(0xFF1B5E20),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2), borderRadius: BorderRadius.circular(15)),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- 1. الشاشة الترحيبية ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1B5E20), Color(0xFF4CAF50)]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.rocket_launch_rounded, size: 80, color: Color(0xFFFFD700)),
              const SizedBox(height: 20),
              const Text('بِـدَايَـة', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 60),
              _buildBtn(context, 'تسجيل مشترك جديد', const Color(0xFFFFD700), Colors.black, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectionPage()));
              }),
              const SizedBox(height: 20),
              _buildBtn(context, 'لدي حساب في بداية', Colors.white.withOpacity(0.2), Colors.white, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              }, isOutlined: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBtn(BuildContext context, String text, Color col, Color textCol, VoidCallback tap, {bool isOutlined = false}) {
    return ElevatedButton(
      onPressed: tap,
      style: ElevatedButton.styleFrom(
        backgroundColor: col,
        minimumSize: const Size(280, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        side: isOutlined ? const BorderSide(color: Colors.white) : BorderSide.none,
      ),
      child: Text(text, style: TextStyle(color: textCol, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}

// --- 2. صفحة تسجيل الدخول (محدثة بـ "نسيت كلمة السر") ---
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(title: const Text('دخول - بداية'), backgroundColor: const Color(0xFF1B5E20)),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('مرحباً بك مجدداً', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
            const SizedBox(height: 40),
            TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'رقم الهاتف', prefixIcon: Icon(Icons.phone, color: Color(0xFF1B5E20))),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: _isObscured,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'كلمة المرور',
                prefixIcon: const Icon(Icons.lock, color: Color(0xFF1B5E20)),
                suffixIcon: IconButton(icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _isObscured = !_isObscured)),
              ),
            ),
            const SizedBox(height: 10),
            // إضافة رابط نسيت كلمة السر
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: const Text('نسيت كلمة السر؟', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _showFloatingSuccess(context, 'تم الدخول بنجاح', Colors.green),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20), minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              child: const Text('دخول', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. صفحة اختيار نوع الحساب ---
class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(title: const Text('انضم إلى بداية'), backgroundColor: const Color(0xFF1B5E20)),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            _buildSelectionCard(context, 'أنا تاجر', 'أعرض بضاعتي للمسوقين', Icons.storefront_rounded, Colors.green, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantRegistrationPage()));
            }),
            const SizedBox(height: 20),
            _buildSelectionCard(context, 'أنا مسوق', 'أربح عمولات من التسويق', Icons.auto_graph_rounded, Colors.orange, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MarketerRegistrationPage()));
            }),
          ],
        ),
      ),
    );
  }
  Widget _buildSelectionCard(BuildContext context, String title, String sub, IconData icon, Color color, VoidCallback tap) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: tap,
      ),
    );
  }
}

// --- 4. صفحة تسجيل التاجر (كاملة) ---
class MerchantRegistrationPage extends StatefulWidget {
  const MerchantRegistrationPage({super.key});
  @override
  State<MerchantRegistrationPage> createState() => _MerchantRegistrationPageState();
}

class _MerchantRegistrationPageState extends State<MerchantRegistrationPage> {
  String? paymentMethod;
  String? accountType;
  List<String?> multiAccountTypes = [null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(title: const Text('بيانات التاجر'), backgroundColor: const Color(0xFF1B5E20)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('المعلومات الشخصية'),
            _buildInput('الاسم الكامل', Icons.person),
            _buildInput('رقم الهاتف', Icons.phone, type: TextInputType.phone),
            _buildInput('الدولة', Icons.public, isLast: true),
            const SizedBox(height: 25),
            _sectionTitle('بيانات التحصيل'),
            _buildDropdown(
              label: 'طريقة التحصيل',
              icon: Icons.account_balance_wallet,
              items: ['كريمي جيب', 'ون كاش', 'كاش', 'جوالي', 'حسابات متعددة'],
              value: paymentMethod,
              onChanged: (val) => setState(() { paymentMethod = val; accountType = null; }),
            ),
            const SizedBox(height: 15),
            if (paymentMethod == 'حسابات متعددة') ...[
              for (int i = 0; i < 4; i++) _buildMultiAccountRow(i),
            ] 
            else if (paymentMethod != null) ...[
              _buildDropdown(label: 'نوع الحساب', icon: Icons.category, items: ['نقطة بيع', 'حساب شخصي'], value: accountType, onChanged: (v) => setState(() => accountType = v)),
              if (accountType == 'نقطة بيع') ...[
                const SizedBox(height: 15),
                _buildInput('رقم نقطة البيع', Icons.storefront),
                _buildUploadBox('إضافة صورة الباركود'),
              ] else if (accountType == 'حساب شخصي') ...[
                const SizedBox(height: 15),
                _buildInput('رقم حسابك المالي', Icons.account_box),
              ],
            ],
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _showFloatingSuccess(context, 'تم حفظ بيانات التاجر', Colors.green),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20), minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              child: const Text('تأكيد التسجيل', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiAccountRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              textInputAction: index < 3 ? TextInputAction.next : TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'رقم الحساب ${index + 1}',
                suffixIcon: multiAccountTypes[index] == 'نقطة بيع' ? const Icon(Icons.camera_alt, color: Colors.blue) : null,
              ),
            ),
          ),
          const SizedBox(width: 10),
          DropdownButton<String>(
            value: multiAccountTypes[index],
            hint: const Text('النوع'),
            items: ['نقطة بيع', 'حساب شخصي'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) => setState(() => multiAccountTypes[index] = val),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))));
  Widget _buildInput(String hint, IconData icon, {TextInputType type = TextInputType.text, bool isLast = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextFormField(keyboardType: type, textInputAction: isLast ? TextInputAction.done : TextInputAction.next, decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon, color: const Color(0xFF1B5E20)))),
  );
  Widget _buildDropdown({required String label, required IconData icon, required List<String> items, String? value, required Function(String?) onChanged}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: DropdownButtonHideUnderline(child: DropdownButton<String>(isExpanded: true, hint: Text(label), value: value, items: items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: onChanged)),
  );
  Widget _buildUploadBox(String text) => Container(width: double.infinity, padding: const EdgeInsets.all(15), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15)), child: Column(children: [const Icon(Icons.qr_code), Text(text)]));
}

// --- 5. صفحة تسجيل المسوق (محدثة بالانتقال السلس) ---
class MarketerRegistrationPage extends StatefulWidget {
  const MarketerRegistrationPage({super.key});
  @override
  State<MarketerRegistrationPage> createState() => _MarketerRegistrationPageState();
}

class _MarketerRegistrationPageState extends State<MarketerRegistrationPage> {
  String? paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(title: const Text('بيانات المسوق'), backgroundColor: const Color(0xFF1B5E20)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('أهلاً بك في فريق بداية! 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            // تفعيل الانتقال السلس هنا
            _buildInput('الاسم الكامل', Icons.person),
            _buildInput('رقم الهاتف', Icons.phone, type: TextInputType.phone),
            _buildInput('المدينة', Icons.location_on, isLast: true),
            const SizedBox(height: 25),
            _buildDropdown(label: 'اختر المحفظة المالية', icon: Icons.wallet, items: ['كريمي جيب', 'ون كاش', 'جوالي'], value: paymentMethod, onChanged: (v) => setState(() => paymentMethod = v)),
            const SizedBox(height: 15),
            if (paymentMethod != null)
              _buildInput('رقم حسابك في $paymentMethod', Icons.account_balance_wallet, isLast: true),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _showFloatingSuccess(context, 'تم التسجيل في بداية', Colors.orange), 
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20), minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), 
              child: const Text('بدء رحلة الأرباح', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint, IconData icon, {TextInputType type = TextInputType.text, bool isLast = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextFormField(
      keyboardType: type, 
      textInputAction: isLast ? TextInputAction.done : TextInputAction.next, // هذا ما يحل مشكلة الانتقال
      decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon, color: const Color(0xFF1B5E20))),
    ),
  );

  Widget _buildDropdown({required String label, required IconData icon, required List<String> items, String? value, required Function(String?) onChanged}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: DropdownButtonHideUnderline(child: DropdownButton<String>(isExpanded: true, hint: Text(label), value: value, items: items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: onChanged)),
  );
}

void _showFloatingSuccess(BuildContext context, String msg, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg, textAlign: TextAlign.center), behavior: SnackBarBehavior.floating, backgroundColor: color, margin: const EdgeInsets.all(20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))));
}