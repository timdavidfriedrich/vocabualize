import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';

const _maxMessageLength = 2000;

class const ReportForm({
  super.key,
  required final String _title,
  required final Widget _header,
  required final TextEditingController _controller,
  required final String _fieldHint,
  required final int _minLines,
  required final bool _canSend,
  required final bool _isSending,
  required final VoidCallback _onSend,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: Text(_title),
      ),
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: Spacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(Spacing.xxl),
                children: [
                  _header,
                  const SizedBox(height: Spacing.xl),
                  TextField(
                    controller: _controller,
                    minLines: _minLines,
                    maxLines: null,
                    maxLength: _maxMessageLength,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(hintText: _fieldHint),
                  ),
                  Text(
                    context.s.reportFeedbackContextHint,
                    style: context.t.bodySmall?.copyWith(color: context.c.onSurfaceVariant),
                  ),
                  const SizedBox(height: Spacing.m),
                  ConnectionRequiredNotice(message: context.s.reportOfflineMessage),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xxl),
              child: BlocBuilder<ConnectivityCubit, bool>(
                builder: (context, isConnected) => ElevatedButton(
                  onPressed: _canSend && !_isSending && isConnected ? _onSend : null,
                  child: _isSending
                      ? const SizedBox.square(
                          dimension: Spacing.iconS,
                          child: CircularProgressIndicator(strokeWidth: Spacing.borderWidthMedium),
                        )
                      : Text(context.s.reportSendButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
