// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/machines/models/add_machine_request.dart';
import 'package:bitecope/modules/machines/models/add_machine_response.dart';
import 'package:bitecope/modules/machines/models/delete_machine_request.dart';
import 'package:bitecope/modules/machines/models/delete_machine_response.dart';
import 'package:bitecope/modules/machines/models/get_machine_response.dart';

import 'package:bitecope/modules/machines/providers/machine_provider.dart';

class MachineRepository extends CommonRepository {
  final MachineProvider _machineProvider = MachineProvider();

  Future<GetMachinesResponse?> getMachines() async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final Map<String, dynamic>? _responseMap =
        await _machineProvider.getMachines(_authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final GetMachinesResponse _response =
        GetMachinesResponse.fromMap(_responseMap);
    return _response;
  }

  Future<AddMachineResponse?> addMachine({
    required String name,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final AddMachineRequest request = AddMachineRequest(
      name: name,
    );

    final Map<String, dynamic>? _responseMap =
        await _machineProvider.addMachine(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final AddMachineResponse _response =
        AddMachineResponse.fromMap(_responseMap);
    return _response;
  }

  Future<DeleteMachineResponse?> deleteMachine({
    required String machineID,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final DeleteMachineRequest request = DeleteMachineRequest(
      machineID: machineID,
    );
    final Map<String, dynamic>? _responseMap =
        await _machineProvider.deleteMachine(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final DeleteMachineResponse _response =
        DeleteMachineResponse.fromMap(_responseMap);
    return _response;
  }
}
