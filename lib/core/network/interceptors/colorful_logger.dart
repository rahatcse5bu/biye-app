import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// ANSI color codes for terminal output
class _AnsiColors {
  static const String reset = '\x1B[0m';
  static const String bold = '\x1B[1m';
  
  // Regular colors
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
  
  // Bright colors
  static const String brightRed = '\x1B[91m';
  static const String brightGreen = '\x1B[92m';
  static const String brightYellow = '\x1B[93m';
  static const String brightBlue = '\x1B[94m';
  static const String brightMagenta = '\x1B[95m';
  static const String brightCyan = '\x1B[96m';
  
  // Background colors
  static const String bgRed = '\x1B[41m';
  static const String bgGreen = '\x1B[42m';
  static const String bgYellow = '\x1B[43m';
  static const String bgBlue = '\x1B[44m';
}

/// Beautiful colorful logger for Dio with stack traces
class ColorfulDioLogger extends Interceptor {
  final bool request;
  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;
  final bool error;
  final bool showStackTrace;
  final int maxWidth;

  ColorfulDioLogger({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.showStackTrace = true,
    this.maxWidth = 100,
  });

  void _log(String message, {String color = _AnsiColors.white}) {
    if (kDebugMode) {
      developer.log('$color$message${_AnsiColors.reset}');
    }
  }

  void _printBoxTop(String title, String color, String emoji) {
    final line = '═' * (maxWidth - 4);
    _log('');
    _log('$color╔$line╗${_AnsiColors.reset}');
    _log('$color║ $emoji $title${' ' * (maxWidth - title.length - 7)}║${_AnsiColors.reset}');
    _log('$color╠$line╣${_AnsiColors.reset}');
  }

  void _printBoxBottom(String color) {
    final line = '═' * (maxWidth - 4);
    _log('$color╚$line╝${_AnsiColors.reset}');
  }

  void _printLine(String key, dynamic value, String color) {
    final content = '$key: $value';
    if (content.length > maxWidth - 4) {
      // Split long lines
      final chunks = _splitString(content, maxWidth - 6);
      for (var i = 0; i < chunks.length; i++) {
        if (i == 0) {
          _log('$color║  ${chunks[i]}${_AnsiColors.reset}');
        } else {
          _log('$color║    ${chunks[i]}${_AnsiColors.reset}');
        }
      }
    } else {
      _log('$color║  $content${_AnsiColors.reset}');
    }
  }

  void _printSection(String title, String color) {
    _log('$color╟── $title ──${_AnsiColors.reset}');
  }

  List<String> _splitString(String str, int size) {
    List<String> chunks = [];
    for (var i = 0; i < str.length; i += size) {
      chunks.add(str.substring(i, i + size > str.length ? str.length : i + size));
    }
    return chunks;
  }

  String _prettyJson(dynamic json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      if (json is String) {
        return encoder.convert(jsonDecode(json));
      }
      return encoder.convert(json);
    } catch (e) {
      return json.toString();
    }
  }

  String _getMethodEmoji(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return '📥';
      case 'POST':
        return '📤';
      case 'PUT':
        return '📝';
      case 'DELETE':
        return '🗑️';
      case 'PATCH':
        return '🔧';
      default:
        return '🔄';
    }
  }

  String _getStatusEmoji(int? statusCode) {
    if (statusCode == null) return '❓';
    if (statusCode >= 200 && statusCode < 300) return '✅';
    if (statusCode >= 300 && statusCode < 400) return '↪️';
    if (statusCode >= 400 && statusCode < 500) return '⚠️';
    if (statusCode >= 500) return '🔥';
    return '❓';
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (request) {
      final method = options.method;
      final emoji = _getMethodEmoji(method);
      
      _printBoxTop(
        '🚀 REQUEST │ $method │ ${DateTime.now().toString().split('.')[0]}',
        _AnsiColors.brightCyan,
        emoji,
      );
      
      _log('${_AnsiColors.brightCyan}║  ${_AnsiColors.bold}URL:${_AnsiColors.reset}${_AnsiColors.cyan} ${options.uri}${_AnsiColors.reset}');
      
      if (requestHeader && options.headers.isNotEmpty) {
        _printSection('HEADERS', _AnsiColors.cyan);
        options.headers.forEach((key, value) {
          if (key == 'Authorization' && value != null) {
            final token = value.toString();
            if (token.length > 50) {
              _printLine(key, '${token.substring(0, 50)}...', _AnsiColors.cyan);
            } else {
              _printLine(key, value, _AnsiColors.cyan);
            }
          } else {
            _printLine(key, value, _AnsiColors.cyan);
          }
        });
      }
      
      if (requestBody && options.data != null) {
        _printSection('BODY', _AnsiColors.cyan);
        final prettyBody = _prettyJson(options.data);
        for (final line in prettyBody.split('\n')) {
          _log('${_AnsiColors.cyan}║  $line${_AnsiColors.reset}');
        }
      }
      
      _printBoxBottom(_AnsiColors.cyan);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode ?? 0;
    final emoji = _getStatusEmoji(statusCode);
    final isSuccess = statusCode >= 200 && statusCode < 300;
    final color = isSuccess ? _AnsiColors.brightGreen : _AnsiColors.brightYellow;
    
    final duration = response.requestOptions.extra['startTime'] != null
        ? DateTime.now().difference(response.requestOptions.extra['startTime'] as DateTime).inMilliseconds
        : null;
    
    _printBoxTop(
      '$emoji RESPONSE │ ${response.statusCode} │ ${response.requestOptions.method} │ ${duration != null ? '${duration}ms' : ''}',
      color,
      emoji,
    );
    
    _log('$color║  ${_AnsiColors.bold}URL:${_AnsiColors.reset}$color ${response.requestOptions.uri}${_AnsiColors.reset}');
    _log('$color║  ${_AnsiColors.bold}Status:${_AnsiColors.reset}$color ${response.statusCode} ${response.statusMessage}${_AnsiColors.reset}');
    
    if (responseHeader && response.headers.map.isNotEmpty) {
      _printSection('HEADERS', color);
      response.headers.forEach((key, values) {
        _printLine(key, values.join(', '), color);
      });
    }
    
    if (responseBody && response.data != null) {
      _printSection('BODY', color);
      final prettyBody = _prettyJson(response.data);
      final lines = prettyBody.split('\n');
      // Limit output for very long responses
      final maxLines = 50;
      for (var i = 0; i < lines.length && i < maxLines; i++) {
        _log('$color║  ${lines[i]}${_AnsiColors.reset}');
      }
      if (lines.length > maxLines) {
        _log('$color║  ... (${lines.length - maxLines} more lines)${_AnsiColors.reset}');
      }
    }
    
    _printBoxBottom(color);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      _printBoxTop(
        '❌ ERROR │ ${err.type.name} │ ${err.response?.statusCode ?? 'N/A'}',
        _AnsiColors.brightRed,
        '🔴',
      );
      
      _log('${_AnsiColors.brightRed}║  ${_AnsiColors.bold}URL:${_AnsiColors.reset}${_AnsiColors.red} ${err.requestOptions.uri}${_AnsiColors.reset}');
      _log('${_AnsiColors.brightRed}║  ${_AnsiColors.bold}Method:${_AnsiColors.reset}${_AnsiColors.red} ${err.requestOptions.method}${_AnsiColors.reset}');
      _log('${_AnsiColors.brightRed}║  ${_AnsiColors.bold}Type:${_AnsiColors.reset}${_AnsiColors.red} ${err.type}${_AnsiColors.reset}');
      
      if (err.message != null) {
        _printSection('MESSAGE', _AnsiColors.red);
        _log('${_AnsiColors.red}║  ${err.message}${_AnsiColors.reset}');
      }
      
      if (err.response != null) {
        _printSection('RESPONSE', _AnsiColors.red);
        _log('${_AnsiColors.red}║  Status: ${err.response?.statusCode} ${err.response?.statusMessage}${_AnsiColors.reset}');
        if (err.response?.data != null) {
          final prettyBody = _prettyJson(err.response?.data);
          for (final line in prettyBody.split('\n').take(20)) {
            _log('${_AnsiColors.red}║  $line${_AnsiColors.reset}');
          }
        }
      }
      
      if (err.error != null) {
        _printSection('ERROR DETAILS', _AnsiColors.red);
        _log('${_AnsiColors.red}║  ${err.error}${_AnsiColors.reset}');
      }
      
      if (showStackTrace && err.stackTrace != null) {
        _printSection('📚 STACK TRACE', _AnsiColors.brightMagenta);
        final stackLines = err.stackTrace.toString().split('\n');
        // Show only relevant stack trace lines (limit to 15)
        var count = 0;
        for (final line in stackLines) {
          if (count >= 15) {
            _log('${_AnsiColors.magenta}║  ... (${stackLines.length - count} more frames)${_AnsiColors.reset}');
            break;
          }
          // Filter out dart internals, show app code
          if (line.contains('package:pnc_nikah_app') || 
              line.contains('package:dio') ||
              count < 5) {
            _log('${_AnsiColors.magenta}║  $line${_AnsiColors.reset}');
            count++;
          }
        }
      }
      
      _printBoxBottom(_AnsiColors.red);
    }
    handler.next(err);
  }
}
