import 'package:programacion_pruebas/backend/api_requests/api_calls.dart';

import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'update_estudio_informacion_model.dart';
export 'update_estudio_informacion_model.dart';

import 'package:programacion_pruebas/configuracion_pruebas/definicion_estudios/definicion_estudios_widget.dart';

class UpdateEstudioInformacionWidget extends StatefulWidget {
  final int pIdEstudio;
  final String pDiasProcesamiento;
  final String pTiempoProcesamiento;
  final String pTecnica;
  final String pIdTipoMuestra;
  final String pIdTipotubo;
  final String pIdEstabilidad;
  final String pIdIndicacion;
  final String pVisibilidad;

  const UpdateEstudioInformacionWidget(
      {
      required this.pIdEstudio,
      required this.pDiasProcesamiento,
      required this.pTiempoProcesamiento,
      required this.pTecnica,
      required this.pIdTipotubo,
      required this.pIdTipoMuestra,
      required this.pIdEstabilidad,
      required this.pIdIndicacion,
      required this.pVisibilidad, Key? key}):super(key: key);

  @override
  State<UpdateEstudioInformacionWidget> createState() =>
      _UpdateEstudioInformacionWidgetState();
}

class _UpdateEstudioInformacionWidgetState
    extends State<UpdateEstudioInformacionWidget> {

  String temporalTipoMuestra = "";

  String tipoMuestraSeleccionada = "";
  String descripcionTipoMuestra = "";

  String tipoTuboSeleccionado = "";
  String descripcionTubo = "";

  String tipoEstabilidadSeleccionada = "";
  String descripcionEstabilidadMuestra = "";

  String tipoIndicacionSeleccionada = "";
  String descripcionIndicacion = "";

  String tipoEstudioSeleccionado = "";

  List<dynamic> tiposMuestraList = [];
  List<dynamic> tiposTubosList = [];
  List<dynamic> estabilidadMuestraList = [];
  List<dynamic> IndicacionesList = [];
  List<dynamic> EstudiosWebList = [];
  List<dynamic> EstudiosList = [];

  Future<void> _fetchTiposMuestra() async {
    try {
      ApiGetTipoMuestra apiCall = ApiGetTipoMuestra();
      List<dynamic> dataTipoMuestraList = await apiCall.fetchTipoMuestra();

      setState(() {
        tiposMuestraList = dataTipoMuestraList;
      });
    } catch (e) {
      print("Error al obtener los tipos de muestra: $e");
      // Aquí puedes mostrar un mensaje de error en la UI o hacer algo más con el error.
    }
  }

  String _getDescripcionTipoMuestra(String pTipoMuestra, int pIdTipoMuestra) {
    String response = "Sin datos";
    for (int i = 0; i < tiposMuestraList.length; i++) {
      String consulta = tiposMuestraList[i]["DESCRIPCION_TIPO_MUESTRA"];

      // Si se proporciona pTipoMuestra pero no pIdTipoMuestra
      if (pTipoMuestra.isNotEmpty && pIdTipoMuestra == 0) {
        if (consulta == pTipoMuestra) {
          
          response = tiposMuestraList[i]["TIPO_MUESTRA_ID"].toString() + " | " + tiposMuestraList[i]["DESCRIPCION_TIPO_MUESTRA"];
          break; // Salimos del bucle si encontramos una coincidencia
        }
      }
      // Si se proporciona pIdTipoMuestra pero no pTipoMuestra
      else if (pIdTipoMuestra != 0 && pTipoMuestra.isEmpty) {
        if (tiposMuestraList[i]["TIPO_MUESTRA_ID"] == pIdTipoMuestra) {
          response = tiposMuestraList[i]["DESCRIPCION_TIPO_MUESTRA"];
          break; // Salimos del bucle si encontramos una coincidencia
        }
      }
    }

    return response;
  }
// 
  int _getIdTipoMuestra(String pTipoMuestra) {
    int IdTipoMuestra = 0;

    for (int i = 0; i < tiposMuestraList.length; i++) {
      String consulta = tiposMuestraList[i]["TIPO_MUESTRA_ID"].toString() + " | " + tiposMuestraList[i]["DESCRIPCION_TIPO_MUESTRA"];

      if (consulta == pTipoMuestra) {
        IdTipoMuestra = tiposMuestraList[i]["TIPO_MUESTRA_ID"];
      }
    }
    return IdTipoMuestra;
  }

  Future<void> _fetchTipoTubo() async {
    try {
      ApiTipoTubo apiCall = ApiTipoTubo();
      List<dynamic> dataTipoTubo = await apiCall.fetchTipoTubo();
      // Save in
      setState(() {
        tiposTubosList = dataTipoTubo;
      });
    } catch (e) {
      print("Error al obtener los tipos de tubos: $e");
      // Puedes mostrar un mensaje de error en la UI si es necesario.
    }
  }

  String _getDescripcionTipoTubo(String pTipoTubo, int pIdTipoTubo) {
    String response = "Sin datos";
    
    for (int i = 0; i < tiposTubosList.length; i++) {
      String consulta = tiposTubosList[i]["TIPO_TUBO_ID"].toString() +
          " | " +
          tiposTubosList[i]["DESCRIPCION_TIPO_TUBO"];

      if (pTipoTubo.isNotEmpty && pIdTipoTubo == 0) {
        if (consulta == pTipoTubo) {
          _model.textController3.text =
              tiposTubosList[i]["DESCRIPCION_TIPO_TUBO"];
          response = tiposTubosList[i]["DESCRIPCION_TIPO_TUBO"];
        }
      } else if (pIdTipoTubo != 0 && pTipoTubo.isEmpty) {
        // Aquí actualizamos la respuesta, pero seguimos buscando otros casos
        if (tiposTubosList[i]["TIPO_TUBO_ID"] == pIdTipoTubo) {
          response = tiposTubosList[i]["DESCRIPCION_TIPO_TUBO"];
          break; // Salir del loop ya que hemos encontrado el match
        }
      }
    }

    return response; // Retorna el valor correcto de `response`
  }

  int _getIdTipoTubo(String pTipoTubo) {
    int IdTipoTubo = 0;

    for (int i = 0; i < tiposTubosList.length; i++) {
      String consulta = tiposTubosList[i]["TIPO_TUBO_ID"].toString() +
          " | " +
          tiposTubosList[i]["DESCRIPCION_TIPO_TUBO"];

      if (consulta == pTipoTubo) {
        IdTipoTubo = tiposTubosList[i]["TIPO_TUBO_ID"];
      }
    }
    return IdTipoTubo;
  }

  Future<void> _fetchEstabilidadMuestra() async {
    try {
      ApiEstabilidad apiCall = ApiEstabilidad();
      List<dynamic> dataEstabilidadMuestras = await apiCall.fetchEstabilidad();
      // Save in
      setState(() {
        estabilidadMuestraList = dataEstabilidadMuestras;
      });
    } catch (e) {
      print("Error al obtener la programación: $e");
      // Puedes mostrar un mensaje de error en la UI si es necesario.
    }
  }

  String _getDescripcionEstabilidadMuestra(
      String pEstabilidadMuestra, int pIdEstabilidadMuestra) {
    String response = "Sin datos";
    for (int i = 0; i < estabilidadMuestraList.length; i++) {
      String consulta =
          estabilidadMuestraList[i]["ESTABILIDAD_MUESTRA_ID"].toString() +
              " | " +
              estabilidadMuestraList[i]["DESCRIPCION_ESTABILIDAD_MUESTRA"];
      if (pEstabilidadMuestra.isNotEmpty && pIdEstabilidadMuestra == 0) {
        if (consulta == pEstabilidadMuestra) {
          _model.textController2.text =
              estabilidadMuestraList[i]["DESCRIPCION_ESTABILIDAD_MUESTRA"];
        }
      } else if (pEstabilidadMuestra.isEmpty && pIdEstabilidadMuestra != 0) {
        if (estabilidadMuestraList[i]["ESTABILIDAD_MUESTRA_ID"] ==
            pIdEstabilidadMuestra) {
          return response =
              estabilidadMuestraList[i]["DESCRIPCION_ESTABILIDAD_MUESTRA"];
        }
      }
    }
    return response;
  }

  int _getIdEstabilidadMuestra(String pEstabilidadMuestra) {
    int IdEstabilidad = 0;

    for (int i = 0; i < estabilidadMuestraList.length; i++) {
      String consulta =
          estabilidadMuestraList[i]["ESTABILIDAD_MUESTRA_ID"].toString() +
              " | " +
              estabilidadMuestraList[i]["DESCRIPCION_ESTABILIDAD_MUESTRA"];

      if (consulta == pEstabilidadMuestra) {
        IdEstabilidad = estabilidadMuestraList[i]["ESTABILIDAD_MUESTRA_ID"];
      }
    }
    return IdEstabilidad;
  }

  Future<void> _fetchIndicaciones() async {
    try {
      ApiIndicaciones apiCall = ApiIndicaciones();
      List<dynamic> dataIndicaciones = await apiCall.fetchIndicaciones();
      // Save in
      setState(() {
        IndicacionesList = dataIndicaciones;
      });
    } catch (e) {
      print("Error al obtener las indicaciones: $e");
      // Puedes mostrar un mensaje de error en la UI si es necesario.
    }
  }

  String _formatDescripcionConSaltos(String descripcion) {
    // Este método inserta saltos de línea antes de cada número seguido de un punto
    return descripcion.replaceAll(RegExp(r'(?=\d+\.\s)'), '\n');
  }

  String _getDescripcionIndicacion(String pIndicacion, int pIdIndicacion) {
    String response = "Sin datos"; // Default response
    for (int i = 0; i < IndicacionesList.length; i++) {
      String consulta = IndicacionesList[i]["INDICACION_ID"].toString() +
          " | " +
          IndicacionesList[i]["DESCRIPCION_INDICACION"];

      // Case 1: pIndicacion is not empty and pIdIndicacion is 0
      if (pIndicacion.isNotEmpty && pIdIndicacion == 0) {
        if (consulta == pIndicacion) {
          String descripcionOriginal =
              IndicacionesList[i]["DESCRIPCION_INDICACION"];
          String formattedDescription =
              _formatDescripcionConSaltos(descripcionOriginal);

          // Set formatted description
          //_model.textController4.text = formattedDescription;

          // Translate the status
          bool estado = IndicacionesList[i]["ESTADO_INDICACION"];
          String traducirEstado = estado ? "Activa" : "Inactiva";

          // Set translated status
          //_model.textController5.text = traducirEstado;

          // Return the formatted description
          return formattedDescription;
        }
      }
      // Case 2: pIndicacion is empty and pIdIndicacion is not 0
      else if (pIndicacion.isEmpty && pIdIndicacion != 0) {
        if (IndicacionesList[i]["INDICACION_ID"] == pIdIndicacion) {
          String descripcionOriginal =
              IndicacionesList[i]["DESCRIPCION_INDICACION"];
          String formattedDescription =
              _formatDescripcionConSaltos(descripcionOriginal);

          // Return the formatted description
          return formattedDescription;
        }
      }
    }
    // If no match was found, return the default response
    return response;
  }

  int _getIdIndicacion(String pIndicacion) {
    int IdIndicacion = 0;

    for (int i = 0; i < IndicacionesList.length; i++) {
      String consulta = IndicacionesList[i]["INDICACION_ID"].toString() +
          " | " +
          IndicacionesList[i]["DESCRIPCION_INDICACION"];

      if (consulta == pIndicacion) {
        IdIndicacion = IndicacionesList[i]["INDICACION_ID"];
      }
    }
    return IdIndicacion;
  }

  bool _getEstadoIndicacion(String pIndicacion) {
    bool IdIndicacion = false;

    for (int i = 0; i < IndicacionesList.length; i++) {
      String consulta = IndicacionesList[i]["INDICACION_ID"].toString() +
          " | " +
          IndicacionesList[i]["DESCRIPCION_INDICACION"];
      print(IndicacionesList);
      if (consulta == pIndicacion) {
        IdIndicacion = IndicacionesList[i]["ESTADO_INDICACION"];
      }
    }
    return IdIndicacion;
  }

  late UpdateEstudioInformacionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _fetchTiposMuestra();
    _fetchTipoTubo();
    _fetchEstabilidadMuestra();
    print(widget.pIdEstudio);
    
    /* Future.delayed(Duration(seconds: 2), () {
        
      _getDescripcionTipoMuestra(widget.pIdTipoMuestra, 0);
        //print(_getDescripcionTipoMuestra(widget.pIdTipoMuestra, 0));
    }); */

    _model = createModel(context, () => UpdateEstudioInformacionModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();
    _model.textController1.text = widget.pTecnica;

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textController2.text = widget.pDiasProcesamiento;

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();
    _model.textController3.text = widget.pTiempoProcesamiento;

    
    _model.switchValue = false;
    if (widget.pVisibilidad == "Activa"){
      _model.switchValue = true;
    }else if (widget.pVisibilidad == "Inactiva"){
      _model.switchValue = false;
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0x4E14181B),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Spacer(),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          height: 800.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 20.0,
                                              borderWidth: 1.0,
                                              buttonSize: 40.0,
                                              icon: Icon(
                                                Icons.close,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
                                              ),
                                              onPressed: () async {
                                                tiposMuestraList.clear();
                                                estabilidadMuestraList.clear();
                                                tiposTubosList.clear();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Editar Estudio',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily:
                                                              'Inter Tight',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 32.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Tecnica',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController1,
                                                      focusNode: _model
                                                          .textFieldFocusNode1,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                      maxLines: 100,
                                                      minLines: 1,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .textController1Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Días de procesamiento',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController2,
                                                      focusNode: _model
                                                          .textFieldFocusNode2,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                      maxLines: 100,
                                                      minLines: 1,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .textController2Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Tiempo de procesamiento',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController3,
                                                      focusNode: _model
                                                          .textFieldFocusNode3,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .textController3Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Tipo de Muestra',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .dropDownValueController1 ??=
                                                        FormFieldController<
                                                            String>(widget.pIdTipoMuestra),
                                                    options: tiposMuestraList
                                                                .map<String>(
                                                                    (tipoMuestra) =>
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        tipoMuestra["TIPO_MUESTRA_ID"]
                                                                            .toString() +
                                                                        " | " +
                                                                        tipoMuestra[
                                                                            "DESCRIPCION_TIPO_MUESTRA"])
                                                                .toList(),
                                                    onChanged: (String? val) {
                                                      safeSetState(() => _model
                                                              .dropDownValue1 =
                                                          val);
                                                    },
                                                    width: 200.0,
                                                    height: 40.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText: 'Select...',
                                                    searchHintText: 'Search...',
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderWidth: 0.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Tipo de tubo, medio o recipiente',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .dropDownValueController2 ??=
                                                        FormFieldController<
                                                            String>(widget.pIdTipotubo),
                                                    options: tiposTubosList
                                                            .map<String>(
                                                                (tipoTubo) =>
                                                                    // ignore: prefer_interpolation_to_compose_strings
                                                                    tipoTubo[
                                                                            "TIPO_TUBO_ID"]
                                                                        .toString() +
                                                                    " | " +
                                                                    tipoTubo[
                                                                        "DESCRIPCION_TIPO_TUBO"])
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .dropDownValue2 =
                                                            val),
                                                    width: 200.0,
                                                    height: 40.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText: 'Select...',
                                                    searchHintText: 'Search...',
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderWidth: 0.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Estabilidad de la muestra',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .dropDownValueController3 ??=
                                                        FormFieldController<
                                                            String>(widget.pIdEstabilidad),
                                                    options: estabilidadMuestraList
                                                                .map<String>(
                                                                    (estabilidad) =>
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        estabilidad["ESTABILIDAD_MUESTRA_ID"]
                                                                            .toString() +
                                                                        " | " +
                                                                        estabilidad[
                                                                            "DESCRIPCION_ESTABILIDAD_MUESTRA"])
                                                                .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .dropDownValue3 =
                                                            val),
                                                    width: 200.0,
                                                    height: 40.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText: 'Select...',
                                                    searchHintText: 'Search...',
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderWidth: 0.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Indicación del Paciente',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .dropDownValueController4 ??=
                                                        FormFieldController<
                                                            String>(null),
                                                    options: [
                                                      'Option 1',
                                                      'Option 2',
                                                      'Option 3'
                                                    ],
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .dropDownValue4 =
                                                            val),
                                                    width: 200.0,
                                                    height: 40.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText: 'Select...',
                                                    searchHintText: 'Search...',
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderWidth: 0.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Visibilidad Pagina Web',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Switch.adaptive(
                                                    value: _model.switchValue!,
                                                    onChanged:
                                                        (newValue) async {
                                                      safeSetState(() =>
                                                          _model.switchValue =
                                                              newValue);
                                                    },
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                    activeTrackColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                    inactiveTrackColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    inactiveThumbColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        int estadoEstudio = 0;
                                        if(_model.switchValue == true){
                                          estadoEstudio = 1;
                                        }else{
                                          estadoEstudio = 0;
                                        }
                                        ApiConfigurarEstudio apiCall = ApiConfigurarEstudio();
                                        apiCall.updateEstudio(
                                          pIdEstudio: widget.pIdEstudio, 
                                          pIdTipoMuestra: _getIdTipoMuestra(widget.pIdTipoMuestra),
                                          pIdTipoTubo: _getIdTipoTubo(widget.pIdTipotubo), 
                                          pIdEstabilidad: _getIdEstabilidadMuestra(widget.pIdEstabilidad), 
                                          pIdIndicacion: 10, 
                                          pVisibilidad: estadoEstudio, 
                                          pProcesoDias: _model.textController2.text, 
                                          pProcesoTiempo: _model.textController3.text, 
                                          pTecnica: _model.textController1.text
                                          );
                                        context.pushNamed(
                                          'DefinicionEstudios',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 300),
                                            ),
                                          },
                                        );
                                      },
                                      text: 'Guardar',
                                      options: FFButtonOptions(
                                        width: 400.0,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Color(0xFF086DEA),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Spacer(),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
