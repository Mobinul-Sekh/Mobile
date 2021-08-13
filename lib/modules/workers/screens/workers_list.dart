// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/core/common/screens/listing.dart';
import 'package:bitecope/modules/workers/bloc/worker_bloc.dart';
import 'package:bitecope/modules/workers/bloc/worker_list_bloc.dart';
import 'package:bitecope/modules/workers/models/worker.dart';
import 'package:bitecope/modules/workers/screens/view_worker.dart';

class WorkersList extends StatelessWidget {
  const WorkersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerListBloc, WorkerListState>(
      builder: (context, state) {
        return Listing<Worker>(
          title: AppLocalizations.of(context)!.workers,
          data: state.workerListStatus == WorkerListStatus.loading
              ? null
              : state.workers,
          getText: (worker) => worker.name,
          onTap: (context, worker) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider<WorkerBloc>(
                  create: (_) => WorkerBloc(
                    context.read<WorkerListBloc>(),
                  ),
                  child: ViewWorker(worker: worker),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
