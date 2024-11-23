import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_update_tipo_muestra_widget.dart'
    show CreateUpdateTipoMuestraWidget;
import 'package:flutter/material.dart';

class CreateUpdateTipoMuestraModel
    extends FlutterFlowModel<CreateUpdateTipoMuestraWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  ApiCallResponse? apiResultnmd;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
