import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';



import 'package:http/http.dart' as http;

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

String username = "";
String token = "";

/// Start Programacion Group Code

class ProgramacionGroup {
  static String getBaseUrl() => 'https://empresas.clinizad.com';

  static Map<String, String> headers = {};
  static ProgramacionCall programacionCall = ProgramacionCall();
  static ApiGetProgramacionPruebas programacionPruebas =
      ApiGetProgramacionPruebas();
  static ApiGetTipoMuestra tipoMuestra = ApiGetTipoMuestra();
  static ApiTipoTubo tipoTubo = ApiTipoTubo();
  static ApiEstabilidad estabilidadMuestra = ApiEstabilidad();
  static ApiIndicaciones indicaciones = ApiIndicaciones();
  static ApiGetToken apiGetToken = ApiGetToken();
  static ApiLoginCall ApiLogin = ApiLoginCall();
  static ApiConfigurarEstudio configurarEstudio = ApiConfigurarEstudio();
}

// Api for get token of security

class ApiLoginCall {
  Future<bool> call({String? username, String? password}) async {
    final url = Uri.parse('${ProgramacionGroup.getBaseUrl()}/api/SAEP/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('Código de estado: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Decodifica el cuerpo de la respuesta
        final responseBody = jsonDecode(response.body);
        final token = responseBody['access'];
        print('Token: $token');
        // Retorna true si la solicitud fue exitosa
        return true;
      } else {
        print(
            'Error al llamar a la API Login. Código de estado: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        return false; // Retorna false si la solicitud falló
      }
    } catch (e) {
      // Si ocurre un error de red o excepción, imprime el error y retorna false
      print('Excepción durante la solicitud: $e');
      return false;
    }
  }
}

class ApiGetTipoMuestra {
  Future<List<dynamic>> fetchTipoMuestra() async {
    try {
      final String apiUrl =
          '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoMuestra/';

      // Llamamos a la api para obtener el token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String token = data['access'];

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Decode in format utf-8
        String decodedResponse = utf8.decode(response.bodyBytes);
        // save data in variable jsonData
        List<dynamic> jsonData = json.decode(decodedResponse);

        return jsonData;
      } else {
        print(
            "Error al llamar a la API tipo de muestra. Código de estado: ${response.statusCode}");
        return [
          {"Message": "return none", "Status code": '${response.statusCode}'}
        ];
      }
    } catch (error) {
      print("Error al llamar a la API tipo de muestra: $error");
      return [
        {"Message:", "Error al llamar a la API tipo de muestra"}
      ];
    }
  }

  Future<ApiCallResponse> createTipoMuestra({
    required String pDescripcionTipoMuestra, // Cambié para que sea requerido
  }) async {
    try {
      // Validar que el token esté disponible
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Obtén el token de autenticación

      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Construir el cuerpo de la solicitud
      final Map<String, dynamic> requestBody = {
        "pDescripcionTipoMuestra": pDescripcionTipoMuestra
      };

      // Serializar el cuerpo en formato JSON
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la llamada a la API
      final response = await ApiManager.instance.makeApiCall(
        callName: 'CreateTipoMuestra',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoMuestra/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token en los headers
          'Content-Type':
              'application/json', // Asegurar que el tipo de contenido sea JSON
        },
        params: {}, // Si hay parámetros en la URL, aquí se deben añadir
        body: ffApiRequestBody, // Enviar el cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: false,
      );

      // Verificar el estado de la respuesta
      if (response.statusCode == 201) {
        print("Tipo Muestra creada exitosamente.");
        return response; // Devuelve la respuesta exitosa
      } else {
        // Manejar diferentes códigos de error
        print(
            "Error en la API tipo muestra. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      // Capturar cualquier error en el proceso
      print("Error al crear el tipo de muestra: $error");
      rethrow; // Lanza nuevamente el error para manejarlo a otro nivel
    }
  }

  Future<ApiCallResponse> deleteTipoMuestra({
    required int pIdTipoMuestra, // Requerido
  }) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdTipoMuestra": pIdTipoMuestra,
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'deleteTipoMuestra',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoMuestra/', // URL correcta
        callType: ApiCallType.DELETE,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("Tipo Muestra eliminada exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API tipo muestra. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al eliminar el tipo de muestra: $error");
      rethrow;
    }
  }

  Future<ApiCallResponse> updateTipoMuestra({
    required int pIdTipoMuestra, // Requerido
    required String pDescripcionTipoMuestra,
  }) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdTipoMuestra": pIdTipoMuestra,
        "pDescripcionTipoMuestra": pDescripcionTipoMuestra
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'updateTipoMuestra',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoMuestra/', // URL correcta
        callType: ApiCallType.PUT,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("Tipo Muestra actualizada exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API tipo muestra. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al actualizar el tipo de muestra: $error");
      rethrow;
    }
  }
}

class ApiTipoTubo {
  Future<List<dynamic>> fetchTipoTubo() async {
    try {
      final String apiUrl =
          '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoTubo/';

      // Llamamos a la api para obtener el token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String token = data['access'];

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Decode in format utf-8
        String decodedResponse = utf8.decode(response.bodyBytes);
        // save data in variable jsonData
        List<dynamic> jsonData = json.decode(decodedResponse);

        return jsonData;
      } else {
        print(
            "Error al llamar a la API tipo de tubo. Código de estado: ${response.statusCode}");
        return [
          {"Message": "return none", "Status code": '${response.statusCode}'}
        ];
      }
    } catch (error) {
      print("Error al llamar a la API tipo de tubo: $error");
      return [
        {"Message:", "Error al llamar a la API tipo de tubo"}
      ];
    }
  }

  Future<ApiCallResponse> createTipoTubo({
    required String pDescripcionTipoTubo, // Cambié para que sea requerido
  }) async {
    try {
      // Validar que el token esté disponible
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Obtén el token de autenticación

      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Construir el cuerpo de la solicitud
      final Map<String, dynamic> requestBody = {
        "pDescripcionTipoTubo": pDescripcionTipoTubo
      };

      // Serializar el cuerpo en formato JSON
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la llamada a la API
      final response = await ApiManager.instance.makeApiCall(
        callName: 'CreateTipoTubo',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoTubo/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token en los headers
          'Content-Type':
              'application/json', // Asegurar que el tipo de contenido sea JSON
        },
        params: {}, // Si hay parámetros en la URL, aquí se deben añadir
        body: ffApiRequestBody, // Enviar el cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: false,
      );

      // Verificar el estado de la respuesta
      if (response.statusCode == 201) {
        print("Tipo Tubo creado exitosamente.");
        return response; // Devuelve la respuesta exitosa
      } else {
        // Manejar diferentes códigos de error
        print(
            "Error en la API tipo tubo. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      // Capturar cualquier error en el proceso
      print("Error al crear el tipo de tubo: $error");
      rethrow; // Lanza nuevamente el error para manejarlo a otro nivel
    }
  }

  Future<ApiCallResponse> deleteTipoTubo({
    required int pIdTipoTubo, // Requerido
  }) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdTipoTubo": pIdTipoTubo,
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'deleteTipoTubo',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoTubo/', // URL correcta
        callType: ApiCallType.DELETE,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("Tipo de tubo eliminado exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API tipo tubo. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al eliminar el tipo de tubo: $error");
      rethrow;
    }
  }

  Future<ApiCallResponse> updateTipoTubo(
      {required int pIdTipoTubo, // Requerido
      required String pDescripcionTipoTubo}) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdTipoTubo": pIdTipoTubo,
        "pDescripcionTipoTubo": pDescripcionTipoTubo
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'updateTipoTubo',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/TipoTubo/', // URL correcta
        callType: ApiCallType.PUT,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("Tipo Tubo actualizada exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API tipo tubo. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al actualizar el tipo de tubo: $error");
      rethrow;
    }
  }
}

class ApiEstabilidad {
  Future<List<dynamic>> fetchEstabilidad() async {
    try {
      final String apiUrl =
          '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/EstabilidadMuestra/';

      // Llamamos a la api para obtener el token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String token = data['access'];

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Decode in format utf-8
        String decodedResponse = utf8.decode(response.bodyBytes);
        // save data in variable jsonData
        List<dynamic> jsonData = json.decode(decodedResponse);

        return jsonData;
      } else {
        print(
            "Error al llamar a la API estabilidad muestra. Código de estado: ${response.statusCode}");
        return [
          {"Message": "return none", "Status code": '${response.statusCode}'}
        ];
      }
    } catch (error) {
      print("Error al llamar a la API estabilidad muestra: $error");
      return [
        {"Message:", "Error al llamar a la API estabilidad muestra"}
      ];
    }
  }

  Future<ApiCallResponse> createEstabilidadMuestra({
    required String pDescripcionEstabilidad, // Cambié para que sea requerido
  }) async {
    try {
      // Validar que el token esté disponible
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Obtén el token de autenticación

      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Construir el cuerpo de la solicitud
      final Map<String, dynamic> requestBody = {
        "pDescripcionEstabilidad": pDescripcionEstabilidad
      };

      // Serializar el cuerpo en formato JSON
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la llamada a la API
      final response = await ApiManager.instance.makeApiCall(
        callName: 'createEstabilidadMuestra',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/EstabilidadMuestra/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token en los headers
          'Content-Type':
              'application/json', // Asegurar que el tipo de contenido sea JSON
        },
        params: {}, // Si hay parámetros en la URL, aquí se deben añadir
        body: ffApiRequestBody, // Enviar el cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: false,
      );

      // Verificar el estado de la respuesta
      if (response.statusCode == 201) {
        print("Estabilidad de la muestra fué creada exitosamente.");
        return response; // Devuelve la respuesta exitosa
      } else {
        // Manejar diferentes códigos de error
        print(
            "Error en la API estabilidad muestra. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      // Capturar cualquier error en el proceso
      print("Error al crear la estabilidad: $error");
      rethrow; // Lanza nuevamente el error para manejarlo a otro nivel
    }
  }

  Future<ApiCallResponse> deleteEstabilidadMuestra({
    required int pIdEstabilidad, // Requerido
  }) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdEstabilidad": pIdEstabilidad,
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'deleteEstabilidadMuestra',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/EstabilidadMuestra/', // URL correcta
        callType: ApiCallType.DELETE,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("Estabilidad eliminada exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API Estabilidad. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al eliminar la estabilidad: $error");
      rethrow;
    }
  }

  Future<ApiCallResponse> updateEstabilidadMuestra(
      {required int pIdEstabilidadMuestra, // Requerido
      required String pDescripcionEstabilidadMuestra}) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdEstabilidad": pIdEstabilidadMuestra,
        "pDescripcionEstabilidad": pDescripcionEstabilidadMuestra
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'updateEstabilidadMuestra',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/EstabilidadMuestra/', // URL correcta
        callType: ApiCallType.PUT,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("Tipo Tubo actualizada exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API tipo tubo. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al actualizar el tipo de tubo: $error");
      rethrow;
    }
  }
}

class ApiIndicaciones {
  Future<List<dynamic>> fetchIndicaciones() async {
    try {
      final String apiUrl =
          '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/IndicacionPaciente/';

      // Llamamos a la api para obtener el token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String token = data['access'];

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Decode in format utf-8
        String decodedResponse = utf8.decode(response.bodyBytes);
        // save data in variable jsonData
        List<dynamic> jsonData = json.decode(decodedResponse);

        return jsonData;
      } else {
        print(
            "Error al llamar a la API estabilidad muestra. Código de estado: ${response.statusCode}");
        return [
          {"Message": "return none", "Status code": '${response.statusCode}'}
        ];
      }
    } catch (error) {
      print("Error al llamar a la API estabilidad muestra: $error");
      return [
        {"Message:", "Error al llamar a la API estabilidad muestra"}
      ];
    }
  }

  Future<ApiCallResponse> createIndicacion(
      {required String pDescripcionIndicacion,
      required int pEstadoIndicacion}) async {
    try {
      // Validar que el token esté disponible
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Obtén el token de autenticación

      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Construir el cuerpo de la solicitud
      final Map<String, dynamic> requestBody = {
        "pIdIndicacion": 55,
        "pDescripcionIndicacion": pDescripcionIndicacion,
        "pEstadoIndicacion": pEstadoIndicacion.toString()
      };
      print(requestBody);

      // Serializar el cuerpo en formato JSON
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la llamada a la API
      final response = await ApiManager.instance.makeApiCall(
        callName: 'createIndicacion',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/IndicacionPaciente/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token en los headers
          'Content-Type':
              'application/json', // Asegurar que el tipo de contenido sea JSON
        },
        params: {}, // Si hay parámetros en la URL, aquí se deben añadir
        body: ffApiRequestBody, // Enviar el cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: false,
      );

      // Verificar el estado de la respuesta
      if (response.statusCode == 201) {
        print("La indicacion del paciente fue creada exitosamente.");
        return response; // Devuelve la respuesta exitosa
      } else {
        // Manejar diferentes códigos de error
        print(
            "Error en la API Indicaciones. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      // Capturar cualquier error en el proceso
      print("Error al crear la indicacion del paciente: $error");
      rethrow; // Lanza nuevamente el error para manejarlo a otro nivel
    }
  }

  Future<ApiCallResponse> deleteIndicacion({
    required int pIdIndicacion, // Requerido
  }) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdIndicacion": pIdIndicacion,
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'deleteIndicacion',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/IndicacionPaciente/', // URL correcta
        callType: ApiCallType.DELETE,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("Indicacion eliminada exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API Indicación. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al eliminar la indicacion: $error");
      rethrow;
    }
  }

  Future<ApiCallResponse> updateIndicacion(
      {required int pIdIndicacion,
        required String pDescripcionIndicacion,
      required int pEstadoIndicacion}) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdIndicacion": pIdIndicacion,
        "pDescripcionIndicacion": pDescripcionIndicacion,
        "pEstadoIndicacion": pEstadoIndicacion.toString()
      };

      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'updateIndicacion',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/IndicacionPaciente/', // URL correcta
        callType: ApiCallType.PUT,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("La indicación fue actualizada exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API Indicacion. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al actualizar la indicación: $error");
      rethrow;
    }
  }
}


class ApiConfigurarEstudio {
  Future<ApiCallResponse> updateEstudio(
      {required int pIdEstudio,
        required int pIdTipoMuestra,
        required int pIdTipoTubo,
        required int pIdEstabilidad,
        required int pIdIndicacion,
        required int pVisibilidad,
        required String pProcesoDias,
      required String pProcesoTiempo,
      required String pTecnica}) async {
    try {
      // Obtener token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String? token = data['access']; // Token de autenticación
      //print(pIdTipoMuestra);
      if (token == null) {
        throw Exception('Token no disponible');
      }

      // Cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "pIdEstudio": pIdEstudio,
        "pEsVisible": pVisibilidad,
        "pIdIndicacion": pIdIndicacion,
        "pIdTipoMuestra": pIdTipoMuestra,
        "pIdTipoTubo": pIdTipoTubo,
        "pIdEstabilidad": pIdEstabilidad,
        "pProcesoDias": pProcesoDias,
        "pProcesoTiempo": pProcesoTiempo,
        "pTecnica": pTecnica,
      };
      
      // Serializar el cuerpo
      final String ffApiRequestBody = jsonEncode(requestBody);

      // Realizar la solicitud DELETE
      final response = await ApiManager.instance.makeApiCall(
        callName: 'updateIndicacion',
        apiUrl:
            '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/ConfigurarEstudio/', // URL correcta
        callType: ApiCallType.PUT,
        headers: {
          'Authorization': 'Bearer $token', // Incluir el token
          'Content-Type': 'application/json', // Tipo de contenido JSON
        },
        params: {}, // Sin parámetros adicionales en URL
        body: ffApiRequestBody, // Cuerpo en formato JSON
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: true, // Asegurarse que permita cuerpo
      );

      // Verificar la respuesta de la API
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Status 200 o 204 son típicos de DELETE exitoso
        print("El estudio fue actualizado exitosamente.");
        return response; // Respuesta exitosa
      } else {
        print(
            "Error en la API configurar estudio. Código de estado: ${response.statusCode}");
        throw Exception('Error en la API: ${response.statusCode}');
      }
    } catch (error) {
      print("Error al actualizar el estudio: $error");
      rethrow;
    }
  }
}



class ApiEstudiosWeb {
  Future<List<dynamic>> fetchEstudiosWebList() async {
    try {
      final String apiUrl =
          '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/EstudiosWeb/';

      // Llamamos a la api para obtener el token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String token = data['access'];

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Decode in format utf-8
        String decodedResponse = utf8.decode(response.bodyBytes);
        // save data in variable jsonData
        List<dynamic> jsonData = json.decode(decodedResponse);

        return jsonData;
      } else {
        print(
            "Error al llamar a la API Estudios Web. Código de estado: ${response.statusCode}");
        return [
          {"Message": "return none", "Status code": '${response.statusCode}'}
        ];
      }
    } catch (error) {
      print("Error al llamar a la API estudios web: $error");
      return [
        {"Message:", "Error al llamar a la API estudios web"}
      ];
    }
  }
}

class ApiEstudios {
  Future<List<dynamic>> fetchEstudiosList() async {
    try {
      final String apiUrl =
          '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/Estudios/';

      // Llamamos a la api para obtener el token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String token = data['access'];

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Decode in format utf-8
        String decodedResponse = utf8.decode(response.bodyBytes);
        // save data in variable jsonData
        List<dynamic> jsonData = json.decode(decodedResponse);

        return jsonData;
      } else {
        print(
            "Error al llamar a la API Estudios. Código de estado: ${response.statusCode}");
        return [
          {"Message": "return none", "Status code": '${response.statusCode}'}
        ];
      }
    } catch (error) {
      print("Error al llamar a la API estudios: $error");
      return [
        {"Message:", "Error al llamar a la API estudios"}
      ];
    }
  }
}

/* // Api para obtener el nombre del usuario
class ApiGetUserCall {
  Future<Map<String, dynamic>> fetchUsername() async {
    try {
      final String apiUrl = '${ProgramacionGroup.getBaseUrl}/api/getUser/';
      final http.Response response = await http
          .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        username = jsonData["username"];
        return jsonData;
      } else {
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return {};
      }
    } catch (error) {
      print("Error al llamar a la API obtener username: $error");
      return {};
    }
  }
}
 */

class ApiGetToken {
  Future<Map<String, dynamic>> fetchToken() async {
    try {
      // URL de la API
      final String apiUrl = '${ProgramacionGroup.getBaseUrl()}/api/SAEP/';
      /* String? user = dotenv.env['USER_ACCESS_BACK'];
      String? pass = dotenv.env['PASS_ACCESS_BACK']; */

      String? user = "";
      String? pass = "";

      // Cuerpo que enviarás en la solicitud POST
      final Map<String, dynamic> body = {
        'username': user,
        'password': pass,
      };
      // Realiza la solicitud POST
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type':
              'application/json', // Asegúrate de que el tipo de contenido sea JSON
        },
        body: jsonEncode(body), // Convierte el body a JSON
      );

      if (response.statusCode == 200) {
        // Decodifica el JSON de la respuesta para obtener el token
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
        // Retorna el token u otros datos según lo que necesites
        return responseData;
      } else {
        print("Error: ${response.statusCode}");
        return {};
      }
    } catch (error) {
      print("Error al llamar a la API para obtener token: $error");
      return {};
    }
  }
}

// Api for get (programacion de pruebas) list
class ApiGetProgramacionPruebas {
  Future<List<dynamic>> fetchProgramacion() async {
    try {
      final String apiUrl =
          '${ProgramacionGroup.getBaseUrl()}/ProgramacionPruebas/EstudiosWeb/';

      // Llamamos a la api para obtener el token
      ApiGetToken apiCall = ApiGetToken();
      Map<String, dynamic> data = await apiCall.fetchToken();
      String token = data['access'];

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Decode in format utf-8
        String decodedResponse = utf8.decode(response.bodyBytes);
        // save data in variable jsonData
        List<dynamic> jsonData = json.decode(decodedResponse);
        return jsonData;
      } else {
        print(
            "Error al llamar a la API programacion. Código de estado: ${response.statusCode}");
        return [
          {"Message": "return none", "Status code": '${response.statusCode}'}
        ];
      }
    } catch (error) {
      print("Error al llamar a la API programacion: $error");
      return [
        {"Message:", "Error al llamar a la API programacion"}
      ];
    }
  }
}

// Api for get token of security
class ProgramacionCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = ProgramacionGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'programacion',
      apiUrl: '${baseUrl}/app/api/pruebas',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Programacion Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
