// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/routes/route_names.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/block_button.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/core/common/screens/confirm_operation.dart';
import 'package:bitecope/core/common/screens/operation_notification.dart';
import 'package:bitecope/modules/workers/bloc/worker_bloc.dart';
import 'package:bitecope/modules/workers/models/worker.dart';

class ViewWorker extends StatefulWidget {
  final Worker worker;

  const ViewWorker({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  _ViewWorkerState createState() => _ViewWorkerState();
}

class _ViewWorkerState extends State<ViewWorker> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(
            icon: Icons.arrow_back_rounded,
            size: 28,
          ),
          title: UnderlinedTitle(
            title: AppLocalizations.of(context)!.workerDetails,
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: BlocConsumer<WorkerBloc, WorkerState>(
            listener: (context, state) {
              _handleListen(context, state);
            },
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FixedColumnWidth(18),
                        2: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            _tableCell(
                              text: AppLocalizations.of(context)!.workerID,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(),
                            _tableCell(
                              text: widget.worker.id,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.details.toUpperCase(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 12),
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(),
                              1: FixedColumnWidth(18),
                              2: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  _tableCell(
                                    text: AppLocalizations.of(context)!.name,
                                    verticalAlignment:
                                        TableCellVerticalAlignment.fill,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(color: AppColors.darkGrey),
                                  ),
                                  const SizedBox(),
                                  _tableCell(
                                    text: widget.worker.name,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.lightGrey,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowBlack,
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(color: AppColors.darkGrey),
                                ),
                                const SizedBox(height: 6),
                                Text(widget.worker.address),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.lightGrey,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowBlack,
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(color: AppColors.darkGrey),
                                ),
                                const SizedBox(height: 6),
                                Text(widget.worker.description ?? ""),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.error!(context)!,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Theme.of(context).errorColor),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                    child: BlockButton(
                      onTap: () {
                        context
                            .read<WorkerBloc>()
                            .confirmDelete(workerName: widget.worker.name);
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/delete.svg',
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleListen(BuildContext context, WorkerState state) {
    if (state.workerStatus == WorkerStatus.deleteValidated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<WorkerBloc>(),
              child: Builder(
                builder: (_context) =>
                    ConfirmOperation<WorkerBloc, WorkerState>(
                  confirmationPrompt: _deleteConfirmationPrompt(context),
                  onConfirm: () => _context.read<WorkerBloc>().deleteWorker(),
                  dialogText: AppLocalizations.of(context)!.removeWorker,
                  flatButtonText: AppLocalizations.of(context)!.remove,
                  elevatedButtonText: AppLocalizations.of(context)!.no,
                  flipCallback: true,
                  listener: (context, state) {
                    if (state.workerStatus == WorkerStatus.ready) {
                      Navigator.of(context).maybePop();
                    } else if (state.workerStatus == WorkerStatus.done) {
                      Navigator.of(context).pushAndRemoveUntil(
                        _deleteSuccessPage(),
                        ModalRoute.withName(RouteName.workers),
                      );
                    }
                  },
                  isLoading: (state) =>
                      state.workerStatus == WorkerStatus.loading,
                ),
              ),
            );
          },
        ),
      );
    }
  }

  RichText _deleteConfirmationPrompt(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: AppColors.shadowText),
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.tryingTo,
          ),
          TextSpan(
            text:
                "${AppLocalizations.of(context)!.deleteWorker} ${widget.worker.name}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.confirmOperation,
          ),
        ],
      ),
    );
  }

  Route _deleteSuccessPage() {
    return MaterialPageRoute(
      builder: (context) {
        return OperationNotification(
          iconPath: "assets/images/circle_delete.svg",
          title: AppLocalizations.of(context)!.deleted,
          message: AppLocalizations.of(context)!.detailEdited,
          splashImagePath: "assets/images/change_confirmation.svg",
          nextText: AppLocalizations.of(context)!.backToWorkers,
          nextCallback: () {
            Navigator.of(context).maybePop();
          },
        );
      },
    );
  }

  Widget _tableCell({
    required String text,
    TextStyle? style,
    TableCellVerticalAlignment? verticalAlignment,
  }) {
    return TableCell(
      verticalAlignment: verticalAlignment ?? TableCellVerticalAlignment.middle,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.lightGrey,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowBlack,
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ),
    );
  }
}
