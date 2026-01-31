import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/bkash_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

/// In-app WebView page for bKash payment
/// Handles the entire payment flow within the app and intercepts callbacks
class BkashWebViewPage extends ConsumerStatefulWidget {
  final int amount;
  final String email;
  final String purpose;
  final String? bioUser;

  const BkashWebViewPage({
    super.key,
    required this.amount,
    required this.email,
    this.purpose = 'buy_package',
    this.bioUser,
  });

  @override
  ConsumerState<BkashWebViewPage> createState() => _BkashWebViewPageState();
}

class _BkashWebViewPageState extends ConsumerState<BkashWebViewPage> {
  late WebViewController _controller;
  bool _isInitialLoading = true;
  bool _isWebViewLoading = true;
  bool _isProcessingPayment = false;
  String? _bkashUrl;
  String? _errorMessage;

  // Callback URL patterns to intercept
  static const String _callbackUrlBase = 'pncnikah.com/pay';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    // Delay payment creation to avoid modifying provider during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createPayment();
    });
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setUserAgent('Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36')
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('🌐 Page started: $url');
            if (mounted) {
              setState(() => _isWebViewLoading = true);
            }
          },
          onPageFinished: (String url) {
            debugPrint('✅ Page finished: $url');
            if (mounted) {
              setState(() => _isWebViewLoading = false);
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('❌ WebView error: ${error.description}');
            // Don't show error for minor resource loading issues
            if (error.isForMainFrame == true && mounted) {
              setState(() {
                _errorMessage = 'পেজ লোড করতে সমস্যা হয়েছে: ${error.description}';
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('🔗 Navigation request: ${request.url}');
            return _handleNavigation(request.url);
          },
          onUrlChange: (UrlChange change) {
            debugPrint('🔄 URL changed: ${change.url}');
            if (change.url != null) {
              _checkForCallback(change.url!);
            }
          },
        ),
      );
  }

  Future<void> _createPayment() async {
    setState(() {
      _isInitialLoading = true;
      _errorMessage = null;
    });

    // Build callback URL with parameters
    String callbackUrl = 'https://$_callbackUrlBase';
    final params = <String, String>{
      'purpose': widget.purpose,
    };
    if (widget.bioUser != null && widget.bioUser!.isNotEmpty) {
      params['bio_user'] = widget.bioUser!;
    }

    final queryString = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    callbackUrl = 'https://$_callbackUrlBase?$queryString';

    try {
      final notifier = ref.read(bkashPaymentNotifierProvider.notifier);
      final bkashUrl = await notifier.createPayment(
        amount: widget.amount,
        callbackURL: callbackUrl,
      );

      if (bkashUrl != null && bkashUrl.isNotEmpty) {
        debugPrint('📱 Loading bKash URL: $bkashUrl');
        setState(() {
          _bkashUrl = bkashUrl;
          _isInitialLoading = false;
        });
        // Load the bKash URL in WebView
        await _controller.loadRequest(Uri.parse(bkashUrl));
      } else {
        setState(() {
          _isInitialLoading = false;
          _errorMessage = 'পেমেন্ট তৈরি করতে ব্যর্থ হয়েছে। আবার চেষ্টা করুন।';
        });
      }
    } catch (e) {
      debugPrint('❌ Payment creation error: $e');
      setState(() {
        _isInitialLoading = false;
        _errorMessage = 'পেমেন্ট তৈরি করতে ব্যর্থ হয়েছে: ${e.toString()}';
      });
    }
  }

  NavigationDecision _handleNavigation(String url) {
    // Check if this is the callback URL from bKash
    if (url.contains(_callbackUrlBase)) {
      debugPrint('🎯 Callback URL detected in navigation: $url');
      _handleCallback(url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void _checkForCallback(String url) {
    if (url.contains(_callbackUrlBase)) {
      debugPrint('🎯 Callback URL detected in URL change: $url');
      _handleCallback(url);
    }
  }

  Future<void> _handleCallback(String url) async {
    if (_isProcessingPayment) return; // Prevent multiple processing

    final uri = Uri.parse(url);
    final paymentID = uri.queryParameters['paymentID'];
    final status = uri.queryParameters['status'];

    debugPrint('📋 Callback params - paymentID: $paymentID, status: $status');

    if (status == 'cancel') {
      if (mounted) {
        _showMessage('পেমেন্ট বাতিল করা হয়েছে', isError: true);
        Navigator.pop(context, false);
      }
      return;
    }

    if (status == 'failure') {
      if (mounted) {
        _showMessage('পেমেন্ট ব্যর্থ হয়েছে', isError: true);
        Navigator.pop(context, false);
      }
      return;
    }

    // For success status or when paymentID is present
    if (paymentID != null && paymentID.isNotEmpty) {
      await _processPayment(paymentID);
    } else {
      if (mounted) {
        _showMessage('পেমেন্ট আইডি পাওয়া যায়নি', isError: true);
        Navigator.pop(context, false);
      }
    }
  }

  Future<void> _processPayment(String paymentID) async {
    if (_isProcessingPayment) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      debugPrint('💳 Processing payment: $paymentID');
      final notifier = ref.read(bkashPaymentNotifierProvider.notifier);
      final success = await notifier.processAfterPay(
        paymentID: paymentID,
        email: widget.email,
        purpose: widget.purpose,
      );

      if (mounted) {
        if (success) {
          // Refresh user data from server to get updated points
          await ref.read(authNotifierProvider.notifier).refreshUserPoints();
          
          _showMessage('🎉 পেমেন্ট সফল হয়েছে! পয়েন্ট যোগ হয়েছে।', isError: false);
          Navigator.pop(context, true);
        } else {
          final state = ref.read(bkashPaymentNotifierProvider);
          _showMessage(state.error ?? 'পেমেন্ট প্রক্রিয়াকরণ ব্যর্থ', isError: true);
          Navigator.pop(context, false);
        }
      }
    } catch (e) {
      debugPrint('❌ Payment processing error: $e');
      if (mounted) {
        _showMessage('পেমেন্ট প্রক্রিয়াকরণ ব্যর্থ: ${e.toString()}', isError: true);
        Navigator.pop(context, false);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
      }
    }
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showCancelDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'https://www.bkash.com/sites/default/files/inline-images/logo.png',
                height: 24,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
              const SizedBox(width: 8),
              const Text('বিকাশ পেমেন্ট'),
            ],
          ),
          backgroundColor: const Color(0xFFE2136E), // bKash pink
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _showCancelDialog,
          ),
          actions: [
            if (_bkashUrl != null)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _controller.reload(),
                tooltip: 'রিফ্রেশ করুন',
              ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isInitialLoading) {
      return _buildLoadingState('পেমেন্ট তৈরি হচ্ছে...');
    }

    if (_isProcessingPayment) {
      return _buildLoadingState('পেমেন্ট প্রক্রিয়াকরণ হচ্ছে...');
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isWebViewLoading)
          Container(
            color: Colors.white.withOpacity(0.9),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE2136E)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'লোড হচ্ছে...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingState(String message) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE2136E).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE2136E)),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'অনুগ্রহ করে অপেক্ষা করুন',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red.shade400,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'সমস্যা হয়েছে',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('বাতিল করুন'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _createPayment,
                    icon: const Icon(Icons.refresh),
                    label: const Text('আবার চেষ্টা করুন'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE2136E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange.shade600),
            const SizedBox(width: 8),
            const Text('পেমেন্ট বাতিল করবেন?'),
          ],
        ),
        content: const Text(
          'আপনি কি নিশ্চিত যে পেমেন্ট বাতিল করতে চান? আপনার অর্থ কাটা হবে না।',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('না, থাকুক'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, false); // Close webview page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('হ্যাঁ, বাতিল করুন'),
          ),
        ],
      ),
    );
  }
}
