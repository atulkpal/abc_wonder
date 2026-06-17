import 'package:flutter/material.dart';
import 'package:abc_wonder/models/item_model.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class DetailScreen extends StatefulWidget {
  final List<ItemModel> items;
  final String title;

  const DetailScreen({
    super.key,
    required this.items,
    required this.title,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  double _tapScale = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakCurrent();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _speakCurrent() {
    TtsHelper().speak(widget.items[_currentPage].ttsText);
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> _buildPageDots(int total, int current) {
    const int maxVisible = 7;
    if (total <= maxVisible) {
      return List.generate(total, (i) => _dot(i, current));
    }

    final widgets = <Widget>[];

    void addDot(int i) => widgets.add(_dot(i, current));

    void addGap() {
      widgets.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white38,
        ),
      ));
    }

    if (current <= 3) {
      for (int i = 0; i <= 5; i++) { addDot(i); }
      addGap();
      addDot(total - 1);
    } else if (current >= total - 4) {
      addDot(0);
      addGap();
      for (int i = total - 6; i < total; i++) { addDot(i); }
    } else {
      addDot(0);
      addGap();
      for (int i = current - 1; i <= current + 1; i++) { addDot(i); }
      addGap();
      addDot(total - 1);
    }

    return widgets;
  }

  Widget _dot(int i, int current) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: current == i ? 10 : 7,
      height: current == i ? 10 : 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: current == i
            ? Colors.white
            : Colors.white.withValues(alpha: 0.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final bool showDots = widget.items.length <= 30;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
              _speakCurrent();
            },
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      item.color,
                      item.color.withValues(alpha: 0.7),
                      AppTheme2.background,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      GestureDetector(
                        onTap: _speakCurrent,
                        onTapDown: (_) => setState(() => _tapScale = 0.92),
                        onTapUp: (_) => setState(() => _tapScale = 1.0),
                        onTapCancel: () => setState(() => _tapScale = 1.0),
                        child: AnimatedScale(
                          scale: _tapScale,
                          duration: const Duration(milliseconds: 150),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: isTablet ? 120 : 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: item.color.withValues(alpha: 0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            Text(
                              item.emoji,
                              style: TextStyle(fontSize: isTablet ? 72 : 56),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              item.subtitle,
                              style: TextStyle(
                                fontSize: isTablet ? 28 : 22,
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          if (showDots)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _currentPage > 0
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white.withValues(alpha: _currentPage > 0 ? 0.9 : 0.3),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ..._buildPageDots(widget.items.length, _currentPage),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _currentPage < widget.items.length - 1
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white.withValues(alpha: _currentPage < widget.items.length - 1 ? 0.9 : 0.3),
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _currentPage > 0
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white.withValues(alpha: _currentPage > 0 ? 0.9 : 0.3),
                          size: 32,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${_currentPage + 1} of ${widget.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _currentPage < widget.items.length - 1
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white.withValues(alpha: _currentPage < widget.items.length - 1 ? 0.9 : 0.3),
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AppTheme2 {
  static const Color background = Color(0xFFFFF8E7);
}
