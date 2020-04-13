import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:yumi_note/widget/markdown/builder.dart';

/// A scrolling widget that parses and displays Markdown.
///
/// Supports all GitHub Flavored Markdown from the
/// [specification](https://github.github.com/gfm/).
///
/// See also:
///
///  * [MarkdownBody], which is a non-scrolling container of Markdown.
///  * <https://github.github.com/gfm/>
class YMMarkdown extends YMMarkdownWidget {
  /// Creates a scrolling widget that parses and displays Markdown.
  const YMMarkdown({
    Key key,
    @required String data,
    bool selectable = false,
    MarkdownStyleSheet styleSheet,
    MarkdownStyleSheetBaseTheme styleSheetTheme,
    SyntaxHighlighter syntaxHighlighter,
    MarkdownTapLinkCallback onTapLink,
    String imageDirectory,
    md.ExtensionSet extensionSet,
    MarkdownImageBuilder imageBuilder,
    MarkdownCheckboxBuilder checkboxBuilder,
    this.padding = const EdgeInsets.all(16.0),
    this.controller,
    this.physics,
    this.shrinkWrap = false,
    MarkdownTapBuildComplete buildComplete,
  }) : super(
          key: key,
          data: data,
          selectable: selectable,
          styleSheet: styleSheet,
          styleSheetTheme: styleSheetTheme,
          syntaxHighlighter: syntaxHighlighter,
          onTapLink: onTapLink,
          imageDirectory: imageDirectory,
          extensionSet: extensionSet,
          imageBuilder: imageBuilder,
          checkboxBuilder: checkboxBuilder,
          buildComplete: buildComplete,
        );

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  /// An object that can be used to control the position to which this scroll view is scrolled.
  ///
  /// See also: [ScrollView.controller]
  final ScrollController controller;

  /// How the scroll view should respond to user input.
  ///
  /// See also: [ScrollView.physics]
  final ScrollPhysics physics;

  /// Whether the extent of the scroll view in the scroll direction should be
  /// determined by the contents being viewed.
  ///
  /// See also: [ScrollView.shrinkWrap]
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context, List<Widget> children) {
    return ListView(
      padding: padding,
      controller: controller,
      physics: physics,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}

/// A base class for widgets that parse and display Markdown.
///
/// Supports all standard Markdown from the original
/// [Markdown specification](https://github.github.com/gfm/).
///
/// See also:
///
///  * [YMMarkdown], which is a scrolling container of Markdown.
///  * [MarkdownBody], which is a non-scrolling container of Markdown.
///  * <https://github.github.com/gfm/>
abstract class YMMarkdownWidget extends StatefulWidget {
  /// Creates a widget that parses and displays Markdown.
  ///
  /// The [data] argument must not be null.
  const YMMarkdownWidget({
    Key key,
    @required this.data,
    this.selectable = false,
    this.styleSheet,
    this.styleSheetTheme = MarkdownStyleSheetBaseTheme.material,
    this.syntaxHighlighter,
    this.onTapLink,
    this.imageDirectory,
    this.extensionSet,
    this.imageBuilder,
    this.checkboxBuilder,
    this.fitContent = false,
    this.buildComplete,
  })  : assert(data != null),
        assert(selectable != null),
        super(key: key);

  final MarkdownTapBuildComplete buildComplete;

  /// The Markdown to display.
  final String data;

  /// If true, the text is selectable.
  ///
  /// Defaults to false.
  final bool selectable;

  /// The styles to use when displaying the Markdown.
  ///
  /// If null, the styles are inferred from the current [Theme].
  final MarkdownStyleSheet styleSheet;

  /// Setting to specify base theme for MarkdownStyleSheet
  ///
  /// Default to [MarkdownStyleSheetBaseTheme.material]
  final MarkdownStyleSheetBaseTheme styleSheetTheme;

  /// The syntax highlighter used to color text in `pre` elements.
  ///
  /// If null, the [MarkdownStyleSheet.code] style is used for `pre` elements.
  final SyntaxHighlighter syntaxHighlighter;

  /// Called when the user taps a link.
  final MarkdownTapLinkCallback onTapLink;

  /// The base directory holding images referenced by Img tags with local or network file paths.
  final String imageDirectory;

  /// Markdown syntax extension set
  ///
  /// Defaults to [md.ExtensionSet.gitHubFlavored]
  final md.ExtensionSet extensionSet;

  /// Call when build an image widget.
  final MarkdownImageBuilder imageBuilder;

  /// Call when build a checkbox widget.
  final MarkdownCheckboxBuilder checkboxBuilder;

  /// Whether to allow the widget to fit the child content.
  final bool fitContent;

  /// Subclasses should override this function to display the given children,
  /// which are the parsed representation of [data].
  @protected
  Widget build(BuildContext context, List<Widget> children);

  @override
  _YMMarkdownWidgetState createState() => _YMMarkdownWidgetState();
}

class _YMMarkdownWidgetState extends State<YMMarkdownWidget>
    implements MarkdownBuilderDelegate {
  List<Widget> _children;
  final List<GestureRecognizer> _recognizers = <GestureRecognizer>[];

  @override
  void didChangeDependencies() {
    _parseMarkdown();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(YMMarkdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data ||
        widget.styleSheet != oldWidget.styleSheet) {
      _parseMarkdown();
    }
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _parseMarkdown() {
    final MarkdownStyleSheet fallbackStyleSheet =
        MarkdownStyleSheet.fromTheme(Theme.of(context));
    final MarkdownStyleSheet styleSheet =
        fallbackStyleSheet.merge(widget.styleSheet);

    _disposeRecognizers();

    final List<String> lines = widget.data.split(RegExp(r'\r?\n'));
    final md.Document document = md.Document(
      extensionSet: widget.extensionSet ?? md.ExtensionSet.gitHubFlavored,
      inlineSyntaxes: [TaskListSyntax()],
      encodeHtml: false,
    );
    final YMMarkdownBuilder builder = YMMarkdownBuilder(
      delegate: this,
      selectable: widget.selectable,
      styleSheet: styleSheet,
      imageDirectory: widget.imageDirectory,
      imageBuilder: widget.imageBuilder,
      checkboxBuilder: widget.checkboxBuilder,
      fitContent: widget.fitContent,
      buildComplete: widget.buildComplete,
    );
    _children = builder.build(document.parseLines(lines));
  }

  void _disposeRecognizers() {
    if (_recognizers.isEmpty) return;
    final List<GestureRecognizer> localRecognizers =
        List<GestureRecognizer>.from(_recognizers);
    _recognizers.clear();
    for (GestureRecognizer recognizer in localRecognizers) recognizer.dispose();
  }

  @override
  GestureRecognizer createLink(String href) {
    final TapGestureRecognizer recognizer = TapGestureRecognizer()
      ..onTap = () {
        if (widget.onTapLink != null) widget.onTapLink(href);
      };
    _recognizers.add(recognizer);
    return recognizer;
  }

  @override
  TextSpan formatText(MarkdownStyleSheet styleSheet, String code) {
    code = code.replaceAll(RegExp(r'\n$'), '');
    if (widget.syntaxHighlighter != null) {
      return widget.syntaxHighlighter.format(code);
    }
    return TextSpan(style: styleSheet.code, text: code);
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _children);
}
