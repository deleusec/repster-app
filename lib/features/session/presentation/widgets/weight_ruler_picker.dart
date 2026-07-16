import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

/// "Ruler" weight picker (0 to 200 kg in 0.1 steps): a scrollable horizontal
/// ruler with a center needle, snapping to the tenth, manual entry, fine
/// adjustment buttons and bodyweight ("PC") at 0. Returns the confirmed weight
/// or `null`.
Future<double?> showWeightRulerPicker(
  BuildContext context, {
  required double value,
}) {
  return showGlassSheet<double>(
    context,
    builder: (_) => _WeightRulerSheet(initial: value),
  );
}

const double _tickW = 8;
const int _totalTicks = 2001; // 0.0 to 200.0 in 0.1 steps
const double _maxKg = 200;

class _WeightRulerSheet extends StatefulWidget {
  const _WeightRulerSheet({required this.initial});

  final double initial;

  @override
  State<_WeightRulerSheet> createState() => _WeightRulerSheetState();
}

class _WeightRulerSheetState extends State<_WeightRulerSheet> {
  late final ScrollController _scroll;
  late double _value;
  bool _editing = false;
  late final TextEditingController _input;
  bool _programmatic = false;

  @override
  void initState() {
    super.initState();
    _value = _clamp(widget.initial);
    _scroll = ScrollController(
      initialScrollOffset: (_value * 10).round() * _tickW,
    );
    _input = TextEditingController();
  }

  @override
  void dispose() {
    _scroll.dispose();
    _input.dispose();
    super.dispose();
  }

  double _clamp(double v) =>
      double.parse(v.clamp(0, _maxKg).toStringAsFixed(1));

  void _onScroll() {
    if (_programmatic) return;
    final idx = ((_scroll.offset) / _tickW).round().clamp(0, _totalTicks - 1);
    final v = double.parse((idx * 0.1).toStringAsFixed(1));
    if (v != _value) {
      // Tick on whole kilos only (not every 0.1 subdivision).
      if (idx % 10 == 0) HapticFeedback.selectionClick();
      setState(() => _value = v);
    }
  }

  Future<void> _snap() async {
    final idx = (_scroll.offset / _tickW).round().clamp(0, _totalTicks - 1);
    final target = idx * _tickW;
    if ((_scroll.offset - target).abs() > 0.5) {
      _programmatic = true;
      await _scroll.animateTo(
        target,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      );
      _programmatic = false;
      if (!mounted) return;
      // Only when the snap actually pulled, so it never doubles the per-tick
      // clicks from `_onScroll`.
      await HapticFeedback.lightImpact();
      if (!mounted) return;
    }
    setState(() => _value = double.parse((idx * 0.1).toStringAsFixed(1)));
  }

  Future<void> _jumpTo(double v) async {
    _programmatic = true;
    await _scroll.animateTo(
      (v * 10).round() * _tickW,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    _programmatic = false;
  }

  void _adjust(double delta) {
    final next = _clamp(_value + delta);
    if (next != _value) HapticFeedback.selectionClick();
    setState(() => _value = next);
    _jumpTo(next);
  }

  void _commitInput() {
    final parsed = double.tryParse(_input.text.replaceAll(',', '.'));
    if (parsed != null) {
      final v = _clamp(parsed);
      setState(() {
        _value = v;
        _editing = false;
      });
      _jumpTo(v);
    } else {
      setState(() => _editing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final isPC = _value == 0;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t.session.set.load,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Value (tap to edit)
            SizedBox(
              height: 76,
              child: Center(
                child: _editing
                    ? _buildInput(scheme)
                    : _buildValueButton(scheme, isPC),
              ),
            ),
            const SizedBox(height: 12),

            // Ruler
            SizedBox(
              height: 76,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final half = (constraints.maxWidth / 2) - (_tickW / 2);
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Ticks, with a soft fade on both edges.
                      ShaderMask(
                        shaderCallback: (rect) => const LinearGradient(
                          colors: [
                            Color(0x00000000),
                            Color(0xFF000000),
                            Color(0xFF000000),
                            Color(0x00000000),
                          ],
                          stops: [0, 0.16, 0.84, 1],
                        ).createShader(rect),
                        blendMode: BlendMode.dstIn,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (n) {
                            if (n is ScrollUpdateNotification) {
                              _onScroll();
                            } else if (n is ScrollEndNotification) {
                              _snap();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            controller: _scroll,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: half),
                            itemExtent: _tickW,
                            itemCount: _totalTicks,
                            itemBuilder: (_, i) => _Tick(index: i),
                          ),
                        ),
                      ),
                      // Soft halo behind the needle.
                      IgnorePointer(
                        child: Container(
                          width: 72,
                          height: 76,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.topCenter,
                              radius: 1,
                              colors: [
                                scheme.primary.withValues(alpha: 0.12),
                                scheme.primary.withValues(alpha: 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Needle
                      IgnorePointer(
                        child: Column(
                          children: [
                            CustomPaint(
                              size: const Size(10, 7),
                              painter: _CaretPainter(scheme.primary),
                            ),
                            Container(
                              width: 1.5,
                              height: 52,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    scheme.primary.withValues(alpha: 0.85),
                                    scheme.primary.withValues(alpha: 0.12),
                                    scheme.primary.withValues(alpha: 0),
                                  ],
                                  stops: const [0, 0.75, 1],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Fine adjustments
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final step in const [
                    (-5.0, '−5 kg'),
                    (-0.5, '−0.5'),
                    (0.5, '+0.5'),
                    (5.0, '+5 kg'),
                  ]) ...[
                    Expanded(
                      child: _StepButton(
                        label: step.$2,
                        onTap: () => _adjust(step.$1),
                      ),
                    ),
                    if (step != const (5.0, '+5 kg')) const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(_value),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                  ),
                  child: Text(
                    isPC
                        ? t.session.weight.confirmBodyweight
                        : t.session.weight.confirmKg(value: _value),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueButton(ColorScheme scheme, bool isPC) {
    return GestureDetector(
      onTap: () {
        _input.text = isPC ? '' : '$_value';
        setState(() => _editing = true);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            isPC ? t.session.bw : '$_value',
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              letterSpacing: -2,
              height: 1,
              color: scheme.onSurface,
            ),
          ),
          if (!isPC) ...[
            const SizedBox(width: 8),
            Text(
              'kg',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ] else ...[
            const SizedBox(width: 10),
            Text(
              t.session.weight.bodyweight,
              style: TextStyle(
                fontSize: 16,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInput(ColorScheme scheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            controller: _input,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            onSubmitted: (_) => _commitInput(),
            onTapOutside: (_) => _commitInput(),
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              letterSpacing: -2,
              height: 1,
              color: scheme.onSurface,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: '0',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: scheme.primary, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: scheme.primary, width: 2),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'kg',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _Tick extends StatelessWidget {
  const _Tick({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final isMaj10 = index % 100 == 0;
    final isMaj5 = !isMaj10 && index % 50 == 0;
    final isKg = !isMaj5 && !isMaj10 && index % 10 == 0;
    final isHalf = !isKg && !isMaj5 && !isMaj10 && index % 5 == 0;
    final h = isMaj10
        ? 46.0
        : isMaj5
        ? 36.0
        : isKg
        ? 24.0
        : isHalf
        ? 16.0
        : 9.0;
    final color = isMaj10
        ? const Color(0xFFE4E4E7)
        : isMaj5
        ? const Color(0xFFA1A1AA)
        : isKg
        ? const Color(0xFF71717A)
        : isHalf
        ? const Color(0xFF52525B)
        : const Color(0xFF3F3F46);
    final w = isMaj10 || isMaj5 ? 2.0 : 1.5;
    final label = isMaj10
        ? (index == 0 ? t.session.bw : '${index ~/ 10}')
        : null;

    return Column(
      children: [
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              label,
              style: const TextStyle(fontSize: 9, color: Color(0xFF52525B)),
            ),
          ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Material(
      color: onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: onSurface.withValues(alpha: 0.85),
            ),
          ),
        ),
      ),
    );
  }
}

class _CaretPainter extends CustomPainter {
  _CaretPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CaretPainter oldDelegate) => oldDelegate.color != color;
}
