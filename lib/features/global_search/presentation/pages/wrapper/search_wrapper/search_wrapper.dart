import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';

class GlobalSearchFieldWrapper extends StatefulWidget {
  final Function(String) onSearch;

  const GlobalSearchFieldWrapper({super.key, required this.onSearch});

  @override
  State<GlobalSearchFieldWrapper> createState() =>
      _GlobalSearchFieldWrapperState();
}

class _GlobalSearchFieldWrapperState extends State<GlobalSearchFieldWrapper> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => IFSearchField(
        controller: _controller,
        hint: 'Search perfect invitation cards...',
        focusNode: _focusNode,
        onChanged: widget.onSearch,
        suffix: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              _controller.clear();
              widget.onSearch(_controller.text);
            },
            child: const Icon(Icons.clear),
          ),
        ),
      );
}
