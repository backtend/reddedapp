import 'package:flutter/material.dart';

class PageFive extends StatefulWidget {
  const PageFive({super.key});

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  bool _isRefreshing = false;

  // 模拟数据
  final String _username = 'Astro_Walker';
  final String _deviceId = 'YB-2025-X8F3K1';
  final double _coinBalance = 12580.50;
  final String _appVersion = 'v2.3.1 (build 412)';

  Future<void> _onRefresh() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isRefreshing = false);
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            // ── 顶部 Header ──
            _buildHeader(),

            const SizedBox(height: 16),

            // ── 金币卡片 ──
            _buildCoinCard(context),

            const SizedBox(height: 16),

            // ── 菜单组 1 ──
            _buildMenuGroup([
              _MenuItem(icon: Icons.group_add_outlined,      color: const Color(0xFF6C63FF), label: '邀请好友'),
              _MenuItem(icon: Icons.message_outlined,        color: const Color(0xFF2196F3), label: '我的消息'),
              _MenuItem(icon: Icons.menu_book_outlined,      color: const Color(0xFF4CAF50), label: '使用教程'),
            ]),

            const SizedBox(height: 12),

            // ── 菜单组 2 ──
            _buildMenuGroup([
              _MenuItem(icon: Icons.edit_note_outlined,      color: const Color(0xFFFF7043), label: '创作中心'),
              _MenuItem(icon: Icons.public_outlined,         color: const Color(0xFF00BCD4), label: '我的星球'),
              _MenuItem(icon: Icons.history_outlined,        color: const Color(0xFF9E9E9E), label: '浏览历史'),
              _MenuItem(icon: Icons.build_circle_outlined,   color: const Color(0xFFFF9800), label: '工具箱'),
            ]),

            const SizedBox(height: 12),

            // ── 菜单组 3 ──
            _buildMenuGroup([
              _MenuItem(icon: Icons.wifi_outlined,           color: const Color(0xFF3F51B5), label: '网络选择'),
              _MenuItem(icon: Icons.security_outlined,       color: const Color(0xFFF44336), label: '账号与安全'),
              _MenuItem(icon: Icons.more_horiz_outlined,     color: const Color(0xFF607D8B), label: '更多'),
            ]),

            const SizedBox(height: 32),

            // ── 版本号 ──
            Center(
              child: Text(
                _appVersion,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFBDBDBD),
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ── 顶部用户信息 ──
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
      child: Row(
        children: [
          // 头像
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 32),
          ),

          const SizedBox(width: 16),

          // 右侧三行文字
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 第一行：品牌
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'YITBOX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // 第二行：用户名
              Text(
                _username,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 2),
              // 第三行：设备标识
              Text(
                _deviceId,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFFAAAAAA),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          const Spacer(),

          // 设置图标
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF9E9E9E)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // ── 金币卡片 ──
  Widget _buildCoinCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.monetization_on, color: Color(0xFFFFD700), size: 18),
                SizedBox(width: 6),
                Text(
                  '当前金币余额',
                  style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _coinBalance.toStringAsFixed(0),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildCoinButton(
                    context,
                    label: '充　值',
                    icon: Icons.add_circle_outline,
                    isPrimary: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCoinButton(
                    context,
                    label: '提　现',
                    icon: Icons.account_balance_wallet_outlined,
                    isPrimary: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isPrimary,
  }) {
    return GestureDetector(
      onTap: () => _showToast(context, '$label功能即将开放'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF6C63FF) : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── 菜单分组 ──
  Widget _buildMenuGroup(List<_MenuItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isLast = index == items.length - 1;
            return Column(
              children: [
                _buildMenuItem(item),
                if (!isLast)
                  const Divider(
                    height: 1,
                    indent: 56,
                    endIndent: 16,
                    color: Color(0xFFF0F0F0),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => _showToast(context, '已点击：${item.label}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, color: item.color, size: 20),
              ),
              const SizedBox(width: 14),
              Text(
                item.label,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF2D2D2D),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Color(0xFFDDDDDD), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 数据模型 ──
class _MenuItem {
  final IconData icon;
  final Color color;
  final String label;
  const _MenuItem({required this.icon, required this.color, required this.label});
}