import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';

class CustomDropdown<T> extends FormField<T> {
  CustomDropdown({
    super.key,
    required List<T> items,
    required String hint,
    required String Function(T) itemLabel,
    IconData? icon,
    T? value,
    super.validator,
    Function(T?)? onChanged,
  }) : super(
         initialValue: value,
         builder: (state) {
           return _CustomDropdownBody<T>(
             items: items,
             hint: hint,
             icon: icon,
             itemLabel: itemLabel,
             state: state,
             onChanged: onChanged,
           );
         },
       );
}

class _CustomDropdownBody<T> extends StatefulWidget {
  final List<T> items;
  final String hint;
  final IconData? icon;
  final String Function(T) itemLabel;
  final FormFieldState<T> state;
  final Function(T?)? onChanged;

  const _CustomDropdownBody({
    required this.items,
    required this.hint,
    required this.icon,
    required this.itemLabel,
    required this.state,
    required this.onChanged,
  });

  @override
  State<_CustomDropdownBody<T>> createState() => _CustomDropdownBodyState<T>();
}

class _CustomDropdownBodyState<T> extends State<_CustomDropdownBody<T>>
    with SingleTickerProviderStateMixin {
  final GlobalKey _fieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  bool isOpen = false;

  late AnimationController arrowController;

  @override
  void initState() {
    super.initState();

    arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void toggleDropdown() {
    if (isOpen) {
      closeDropdown();
    } else {
      openDropdown();
    }
  }

  void openDropdown() {
    overlayEntry = _createOverlay();
    Overlay.of(context).insert(overlayEntry!);

    arrowController.forward();
    setState(() => isOpen = true);
  }

  void closeDropdown() {
    overlayEntry?.remove();
    overlayEntry = null;

    arrowController.reverse();
    setState(() => isOpen = false);
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox =
        _fieldKey.currentContext!.findRenderObject() as RenderBox;

    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height + 6),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).cardColor,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.items.map((item) {
                final selected = widget.state.value == item;

                return InkWell(
                  onTap: () {
                    widget.state.didChange(item);
                    widget.onChanged?.call(item);
                    closeDropdown();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Text(
                      widget.itemLabel(item),
                      style: TextStyle(
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    overlayEntry = null;
    arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.state.hasError;

    final inputTheme = Theme.of(context).inputDecorationTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: toggleDropdown,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,

              key: _fieldKey,
              padding:
                  inputTheme.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              decoration: BoxDecoration(
                color: inputTheme.fillColor,
                borderRadius:
                    (inputTheme.border as OutlineInputBorder?)?.borderRadius ??
                    BorderRadius.circular(14),
                border: Border.all(
                  width: 2,
                  color: hasError
                      ? Colors.transparent
                      : isOpen
                      ? (inputTheme.focusedBorder as OutlineInputBorder?)
                                ?.borderSide
                                .color ??
                            Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: Theme.of(context).iconTheme.color,
                      size: 24,
                    ),
                    const SizedBox(width: 20),
                  ],

                  Expanded(
                    child: Text(
                      widget.state.value != null
                          ? widget.itemLabel(widget.state.value as T)
                          : widget.hint,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),

                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(arrowController),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              widget.state.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
