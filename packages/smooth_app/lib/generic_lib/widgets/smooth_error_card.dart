import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_simple_button.dart';
import 'package:smooth_app/generic_lib/design_constants.dart';
import 'package:smooth_app/generic_lib/widgets/smooth_card.dart';
import 'package:smooth_app/helpers/extension_on_text_helper.dart';

class SmoothErrorCard extends StatefulWidget {
  const SmoothErrorCard(
      {Key? key, required this.errorMessage, required this.tryAgainFunction})
      : super(key: key);
  final String errorMessage;
  final void Function() tryAgainFunction;

  @override
  State<SmoothErrorCard> createState() => _SmoothErrorCardState();
}

class _SmoothErrorCardState extends State<SmoothErrorCard> {
  late AppLocalizations _appLocalizations;
  final TextStyle _buttonsTextStyle = const TextStyle(color: Colors.white);
  bool _showErrorText = false;

  final double _horizontalPaddingButtons = VERY_LARGE_SPACE * 4;

  void _setShowErrorText() {
    setState(() {
      _showErrorText = !_showErrorText;
    });
  }

  Widget _getTryAgainButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPaddingButtons,
      ),
      child: SmoothSimpleButton(
        child: Text(
          _appLocalizations.try_again,
          style: _buttonsTextStyle,
        ),
        onPressed: widget.tryAgainFunction,
        minWidth: double.infinity,
      ),
    );
  }

  Widget _getErrorMessage() {
    return Container(
      margin: const EdgeInsets.all(SMALL_SPACE),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            size: 40,
            color: Colors.red,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SMALL_SPACE, vertical: VERY_SMALL_SPACE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _appLocalizations.error_occurred,
                    style: Theme.of(context).textTheme.bodyText2?.apply(
                          fontWeightDelta: 500,
                          color: Colors.red,
                        ),
                  ),
                  const SizedBox(height: VERY_LARGE_SPACE),
                  Text(
                    widget.errorMessage,
                    style: Theme.of(context).textTheme.bodyText2?.apply(
                          fontWeightDelta: 500,
                        ),
                  ).selectable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getErrorButton() {
    if (_showErrorText) {
      return _getErrorMessage();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPaddingButtons,
      ),
      child: SmoothSimpleButton(
        child: Text(
          _appLocalizations.learnMore,
          style: _buttonsTextStyle,
        ),
        onPressed: _setShowErrorText,
        minWidth: double.infinity,
      ),
    );
  }

  Widget _getBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: VERY_LARGE_SPACE,
      ),
      child: Column(
        children: <Widget>[
          _getTryAgainButton(),
          const SizedBox(height: VERY_SMALL_SPACE),
          _getErrorButton(),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SMALL_SPACE),
        child: Text(
          _appLocalizations.there_was_an_error,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: SmoothCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getTitle(),
            _getBody(),
          ],
        ),
      ),
    );
  }
}
