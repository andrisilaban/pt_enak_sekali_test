import 'package:flutter/material.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';
import '../../domain/usecases/filter_products_by_category.dart';

class SplashPage extends StatefulWidget {
  final Widget nextScreen;
  final GetProducts getProducts;
  final SearchProducts searchProducts;
  final FilterProductsByCategory filterProductsByCategory;

  const SplashPage({
    super.key,
    required this.nextScreen,
    required this.getProducts,
    required this.searchProducts,
    required this.filterProductsByCategory,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    _loadData().then((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        _animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => widget.nextScreen),
            );
          }
        });
      }
    });
  }

  Future<void> _loadData() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading data: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PT Enak Sekali',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Memuat...',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              else
                const Text(
                  "Data Berhasil Dimuat!",
                  style: TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
