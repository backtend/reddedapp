import 'package:flutter/material.dart';
import 'dart:math';

// ── 视频数据模型 ──────────────────────────────────
class _VideoData {
  final String id;
  final Color bgColor;
  final List<Color> gradientColors;
  final String avatar;
  final String username;
  final String description;
  final String musicName;
  final int likes;
  final int favorites;
  final int comments;
  final String tag;

  const _VideoData({
    required this.id,
    required this.bgColor,
    required this.gradientColors,
    required this.avatar,
    required this.username,
    required this.description,
    required this.musicName,
    required this.likes,
    required this.favorites,
    required this.comments,
    required this.tag,
  });
}

final List<_VideoData> _mockVideos = [
  _VideoData(
    id: '1',
    bgColor: const Color(0xFF0D0D1A),
    gradientColors: [const Color(0xFF1A0533), const Color(0xFF0D1B4B), const Color(0xFF000D1A)],
    avatar: 'A',
    username: '@nebula_drift',
    description: '宇宙的尽头是什么？带你穿越时空的边界，感受那片无际的星海 🌌✨ #宇宙 #探索 #星空',
    musicName: '♪ Interstellar - Hans Zimmer',
    likes: 248600,
    favorites: 32100,
    comments: 4820,
    tag: '宇宙探索',
  ),
  _VideoData(
    id: '2',
    bgColor: const Color(0xFF0A1A0A),
    gradientColors: [const Color(0xFF0A2E1A), const Color(0xFF051A0D), const Color(0xFF001108)],
    avatar: 'B',
    username: '@forest_soul',
    description: '清晨第一缕阳光穿透雨林，这一刻值得被记录 🌿🌱 #森林 #自然 #治愈系',
    musicName: '♪ Nature Sounds - Ambient',
    likes: 91200,
    favorites: 18700,
    comments: 2340,
    tag: '自然治愈',
  ),
  _VideoData(
    id: '3',
    bgColor: const Color(0xFF1A0A00),
    gradientColors: [const Color(0xFF3D1500), const Color(0xFF1A0800), const Color(0xFF0D0500)],
    avatar: 'C',
    username: '@cyber_wave',
    description: '2077年的城市夜景是这样的，霓虹倒映在雨后的街道 🌆⚡ #赛博朋克 #未来 #城市',
    musicName: '♪ Cyberpunk 2077 OST',
    likes: 562000,
    favorites: 87300,
    comments: 15600,
    tag: '赛博朋克',
  ),
  _VideoData(
    id: '4',
    bgColor: const Color(0xFF00101A),
    gradientColors: [const Color(0xFF001A33), const Color(0xFF000D1A), const Color(0xFF001620)],
    avatar: 'D',
    username: '@deep_ocean',
    description: '深海3000米，这里有地球上最神秘的生命 🌊🐋 #深海 #海洋 #神秘生物',
    musicName: '♪ Ocean Deep - Moby',
    likes: 178400,
    favorites: 45200,
    comments: 6890,
    tag: '深海探秘',
  ),
  _VideoData(
    id: '5',
    bgColor: const Color(0xFF1A1500),
    gradientColors: [const Color(0xFF2E2500), const Color(0xFF1A1200), const Color(0xFF0D0A00)],
    avatar: 'E',
    username: '@desert_wind',
    description: '撒哈拉日落前的最后十分钟，沙丘的颜色变幻莫测 🏜️🌅 #沙漠 #旅行 #绝美风景',
    musicName: '♪ Desert Rose - Sting',
    likes: 334500,
    favorites: 62100,
    comments: 8930,
    tag: '沙漠旅行',
  ),
];

// ── 主页面 ──────────────────────────────────────
class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TabItem(label: '关注', isActive: false),
            const SizedBox(width: 24),
            _TabItem(label: '推荐', isActive: true),
            const SizedBox(width: 24),
            _TabItem(label: '附近', isActive: false),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.white, size: 26),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _mockVideos.length,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (context, index) {
          return _VideoCard(data: _mockVideos[index]);
        },
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  const _TabItem({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white54,
            fontSize: isActive ? 17 : 15,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        if (isActive) ...[
          const SizedBox(height: 3),
          Container(
            width: 20,
            height: 2.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ],
    );
  }
}

// ── 单个视频卡片 ──────────────────────────────────
class _VideoCard extends StatefulWidget {
  final _VideoData data;
  const _VideoCard({super.key, required this.data});

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard> with TickerProviderStateMixin {
  bool _isLiked = false;
  bool _isFavorited = false;
  bool _isFollowing = false;
  late int _likeCount;
  late int _favCount;

  // 动画控制器
  late AnimationController _likeAnim;
  late AnimationController _favAnim;
  late AnimationController _discAnim;
  late AnimationController _enterAnim;
  late Animation<double> _enterFade;
  late Animation<Offset> _enterSlide;

  // 爱心爆炸粒子
  final List<_HeartParticle> _particles = [];
  late AnimationController _particleAnim;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.data.likes;
    _favCount = widget.data.favorites;

    _likeAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _favAnim  = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _discAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _particleAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _enterAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _enterFade  = CurvedAnimation(parent: _enterAnim, curve: Curves.easeOut);
    _enterSlide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _enterAnim, curve: Curves.easeOut));

    _enterAnim.forward();
  }

  @override
  void dispose() {
    _likeAnim.dispose();
    _favAnim.dispose();
    _discAnim.dispose();
    _particleAnim.dispose();
    _enterAnim.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
      if (_isLiked) {
        _spawnParticles();
      }
    });
    _likeAnim.forward(from: 0);
  }

  void _toggleFav() {
    setState(() {
      _isFavorited = !_isFavorited;
      _favCount += _isFavorited ? 1 : -1;
    });
    _favAnim.forward(from: 0);
  }

  void _spawnParticles() {
    final rng = Random();
    _particles.clear();
    for (int i = 0; i < 8; i++) {
      _particles.add(_HeartParticle(
        angle: rng.nextDouble() * pi * 2,
        distance: 30 + rng.nextDouble() * 50,
        size: 6 + rng.nextDouble() * 10,
      ));
    }
    _particleAnim.forward(from: 0);
  }

  String _formatCount(int n) {
    if (n >= 10000) return '${(n / 10000).toStringAsFixed(1)}w';
    if (n >= 1000)  return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final d = widget.data;

    return Stack(
      fit: StackFit.expand,
      children: [
        // ── 背景渐变 (模拟视频) ──
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: d.gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // ── 装饰性光晕 ──
        Positioned(
          top: size.height * 0.15,
          left: -60,
          child: _GlowOrb(color: d.gradientColors[0], size: 220),
        ),
        Positioned(
          bottom: size.height * 0.2,
          right: -40,
          child: _GlowOrb(color: d.gradientColors[1], size: 180),
        ),

        // ── 标签角标 ──
        Positioned(
          top: 110,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Text(
              '# ${d.tag}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ),

        // ── 底部信息层 ──
        Positioned(
          bottom: 0,
          left: 0,
          right: 80,
          child: FadeTransition(
            opacity: _enterFade,
            child: SlideTransition(
              position: _enterSlide,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 36),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 用户名 + 关注
                    Row(
                      children: [
                        Text(
                          d.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => setState(() => _isFollowing = !_isFollowing),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                            decoration: BoxDecoration(
                              color: _isFollowing ? Colors.white24 : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _isFollowing ? Colors.white38 : Colors.white,
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              _isFollowing ? '已关注' : '+ 关注',
                              style: TextStyle(
                                color: _isFollowing ? Colors.white60 : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // 简介
                    Text(
                      d.description,
                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // 音乐滚动条
                    Row(
                      children: [
                        const Icon(Icons.music_note, color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          d.musicName,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── 右侧操作栏 ──
        Positioned(
          right: 10,
          bottom: 60,
          child: FadeTransition(
            opacity: _enterFade,
            child: Column(
              children: [
                // 头像
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [d.gradientColors[0].withOpacity(1), Colors.white24],
                        ),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          d.avatar,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -6,
                      left: 14,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF2D55),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // 点赞
                _buildActionBtn(
                  onTap: _toggleLike,
                  animController: _likeAnim,
                  particles: _particles,
                  particleAnim: _particleAnim,
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  iconColor: _isLiked ? const Color(0xFFFF2D55) : Colors.white,
                  label: _formatCount(_likeCount),
                ),
                const SizedBox(height: 20),

                // 收藏
                _buildFavBtn(),
                const SizedBox(height: 20),

                // 评论
                Column(
                  children: [
                    const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 34),
                    const SizedBox(height: 4),
                    Text(
                      _formatCount(widget.data.comments),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 分享
                const Column(
                  children: [
                    Icon(Icons.reply, color: Colors.white, size: 34),
                    SizedBox(height: 4),
                    Text('分享', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 20),

                // 旋转黑胶
                RotationTransition(
                  turns: _discAnim,
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white24,
                          d.gradientColors[0].withOpacity(0.9),
                          Colors.black87,
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                      border: Border.all(color: Colors.white30, width: 1.5),
                    ),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.white38,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn({
    required VoidCallback onTap,
    required AnimationController animController,
    required List<_HeartParticle> particles,
    required AnimationController particleAnim,
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 粒子
                AnimatedBuilder(
                  animation: particleAnim,
                  builder: (_, __) {
                    return Stack(
                      alignment: Alignment.center,
                      children: particles.map((p) {
                        final t = particleAnim.value;
                        final dx = cos(p.angle) * p.distance * t;
                        final dy = sin(p.angle) * p.distance * t;
                        return Transform.translate(
                          offset: Offset(dx, dy),
                          child: Opacity(
                            opacity: (1 - t).clamp(0, 1),
                            child: Icon(
                              Icons.favorite,
                              color: const Color(0xFFFF2D55),
                              size: p.size,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                // 主图标弹跳
                ScaleTransition(
                  scale: Tween<double>(begin: 1, end: 1.4).animate(
                    CurvedAnimation(parent: animController, curve: Curves.elasticOut),
                  ),
                  child: Icon(icon, color: iconColor, size: 36),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFavBtn() {
    return GestureDetector(
      onTap: _toggleFav,
      child: Column(
        children: [
          ScaleTransition(
            scale: Tween<double>(begin: 1, end: 1.35).animate(
              CurvedAnimation(parent: _favAnim, curve: Curves.elasticOut),
            ),
            child: Icon(
              _isFavorited ? Icons.star : Icons.star_border,
              color: _isFavorited ? const Color(0xFFFFCC00) : Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatCount(_favCount),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ── 光晕球 ──────────────────────────────────────
class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.5), blurRadius: size * 0.8, spreadRadius: size * 0.1),
        ],
        color: color.withOpacity(0.08),
      ),
    );
  }
}

// ── 粒子数据 ─────────────────────────────────────
class _HeartParticle {
  final double angle;
  final double distance;
  final double size;
  const _HeartParticle({required this.angle, required this.distance, required this.size});
}