import 'package:flutter/material.dart';
import 'package:printing_press_app/view/admin/sales_order/sales_order.dart';

// ── Design tokens ────────────────────────────────────────────────────────
class _C {
  _C._();
  static const bg = Color(0xFFF6F4EF);
  static const surface = Colors.white;
  static const border = Color(0xFFE8E4DC);
  static const ink = Color(0xFF17223B);
  static const muted = Color(0xFF86837C);

  static const navy = Color(0xFF17223B);

  static const amber = Color(0xFFB36B1D);
  static const amberBg = Color(0xFFFCEFDA);

  static const indigo = Color(0xFF4C4FE0);
  static const indigoBg = Color(0xFFEEEEFE);

  static const green = Color(0xFF1D9E75);
  static const greenBg = Color(0xFFE1F5EE);
  static const greenBorder = Color(0xFF9FE1CB);

  static const danger = Color(0xFFA32D2D);
  static const dangerBg = Color(0xFFFCEBEB);
}

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // ── Local UI-only state (replace with real data source later) ───────────
  final String _fullName = 'John Doe';
  bool _isLoggingOut = false;
  final bool _isCheckedIn = true;
  final String _checkInTime = '08:42 AM';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String get _firstNameCapitalized {
    if (_fullName.isEmpty) return '';
    return _fullName[0].toUpperCase() + _fullName.substring(1);
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Working late';
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    if (hour < 21) return 'Good evening';
    return 'Working late';
  }

  IconData get _greetingIcon {
    final hour = DateTime.now().hour;
    if (hour < 6 || hour >= 20) return Icons.nightlight_round;
    if (hour < 12) return Icons.wb_twilight_rounded;
    return Icons.wb_sunny_rounded;
  }

  // ── Confirm Logout ───────────────────────────────────────────────────────
  Future<void> _confirmLogout() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: _C.dangerBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: _C.danger,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _C.ink,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You\'ll need to sign in again to access your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: _C.muted,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    // Cancel
                    Expanded(
                      child: GestureDetector(
                        onTap: _isLoggingOut ? null : () => Navigator.pop(ctx),
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: _C.bg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _C.border, width: 0.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _isLoggingOut
                                  ? _C.muted.withOpacity(0.5)
                                  : _C.muted,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Confirm
                    Expanded(
                      child: GestureDetector(
                        onTap: _isLoggingOut
                            ? null
                            : () async {
                                setDialogState(() => _isLoggingOut = true);
                                setState(() => _isLoggingOut = true);

                                // TODO: hook up real logout logic here.
                                await Future.delayed(
                                  const Duration(milliseconds: 800),
                                );

                                if (!ctx.mounted) return;

                                setDialogState(() => _isLoggingOut = false);
                                setState(() => _isLoggingOut = false);

                                Navigator.pop(ctx);

                                // TODO: navigate to your login page, e.g.:
                                // Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(builder: (_) => const LoginPage()),
                                //   (route) => false,
                                // );
                              },
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: _isLoggingOut
                                ? _C.danger.withOpacity(0.7)
                                : _C.danger,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: _isLoggingOut
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Log out',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _buildTopBar()),
                SliverToBoxAdapter(child: _buildStatusStrip()),
                SliverToBoxAdapter(child: _buildSectionHeader('Quick actions')),
                SliverToBoxAdapter(child: _buildActionGrid(context)),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Top Bar ──────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    final fullName = _fullName;
    final initials = fullName.isNotEmpty
        ? fullName
              .trim()
              .split(RegExp(r'\s+'))
              .map((e) => e.isNotEmpty ? e[0] : '')
              .take(2)
              .join()
              .toUpperCase()
        : 'U';

    return Container(
      color: _C.surface,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + Logout row
          Row(
            children: [
              const Spacer(),
              // Avatar
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _C.navy,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Color(0xFFE6F1FB),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Logout Button — swaps to spinner when loading
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _C.bg,
                  shape: BoxShape.circle,
                  border: Border.all(color: _C.border, width: 0.5),
                ),
                child: _isLoggingOut
                    ? const Padding(
                        padding: EdgeInsets.all(11),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _C.muted,
                        ),
                      )
                    : IconButton(
                        onPressed: _confirmLogout,
                        icon: const Icon(Icons.logout_rounded, size: 18),
                        color: _C.muted,
                        tooltip: 'Log out',
                        padding: EdgeInsets.zero,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Greeting banner — the day's single visual anchor
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _C.amberBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _C.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_greetingIcon, color: _C.amber, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _C.amber,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      _firstNameCapitalized,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: _C.ink,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Status Strip ─────────────────────────────────────────────────────────
  Widget _buildStatusStrip() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _C.border, width: 0.5),
        ),
        child: Row(
          children: [
            if (_isCheckedIn) const _PulseDot(),
            if (!_isCheckedIn)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _C.muted,
                ),
              ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 13,
                  color: _C.muted,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  const TextSpan(text: 'Status: '),
                  TextSpan(
                    text: _isCheckedIn ? 'Checked in' : 'Checked out',
                    style: const TextStyle(
                      color: _C.ink,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (_isCheckedIn) TextSpan(text: ' · $_checkInTime'),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: _isCheckedIn ? _C.greenBg : _C.bg,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: _isCheckedIn ? _C.greenBorder : _C.border,
                  width: 0.5,
                ),
              ),
              child: Text(
                _isCheckedIn ? 'Active' : 'Off shift',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _isCheckedIn ? const Color(0xFF0F6E56) : _C.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Header ───────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _C.muted,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // ── Action Grid ──────────────────────────────────────────────────────────
  Widget _buildActionGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _ActionCard(
              title: 'Sales order',
              subtitle: 'Create new sales order',
              icon: Icons.assignment_outlined,
              iconBg: _C.indigoBg,
              iconColor: _C.indigo,
              onTap: () {
                // TODO: navigate to your Sales Orders screen, e.g.:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SalesJobWorksApp()),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionCard(
              title: 'Check in / out',
              subtitle: 'Update status',
              icon: Icons.schedule_rounded,
              iconBg: _C.amberBg,
              iconColor: _C.amber,
              onTap: () {
                // TODO: navigate to your Check In/Out screen, e.g.:
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckInOut()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pulse Dot ─────────────────────────────────────────────────────────────
class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 1.0,
      end: 0.35,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: _C.green,
        ),
      ),
    );
  }
}

// ── Action Card ───────────────────────────────────────────────────────────
class _ActionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _C.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _C.border, width: 0.5),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _C.bg,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Icon(
                    Icons.arrow_outward_rounded,
                    size: 12,
                    color: _C.muted,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.iconBg,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(widget.icon, color: widget.iconColor, size: 19),
                  ),
                  const Spacer(),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _C.ink,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _C.muted,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
