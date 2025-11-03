import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      'image': 'assets/images/apple.png',
      'headline': 'Transforme seus estudos em uma jornada divertida!',
      'description':
          'Sistema de pontos, conquistas e rankings que tornam o aprendizado viciante.',
    },
    {
      'image': 'assets/images/hat.png',
      'headline': 'Prepare-se para ENEM e Vestibulares.',
      'description':
          'Banco de questões do ENEM, FUVEST, UNICAMP e outros vestibulares.',
    },
    {
      'image': 'assets/images/chart.png',
      'headline': 'Rankings e Conquistas',
      'description':
          'Suba no ranking nacional, desbloqueie conquistas especiais e acompanhe seu progresso em tempo real.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
            children: [
              SizedBox(height: h * 0.03),

              // Título e subtítulo fixos no topo
              Text(
                'EDUQUIZ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6A1B9A),
                  fontWeight: FontWeight.w800,
                  fontSize: w * 0.08,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Aprenda de forma gamificada!',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6A1B9A),
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: h * 0.04),

              // Páginas do onboarding
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final data = onboardingData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: h * 0.02),

                        // Imagem principal
                        Container(
                          height: h * 0.3,
                          width: w * 0.6,
                          alignment: Alignment.center,
                          child: Image.asset(
                            data['image'],
                            width: w * 0.45,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 100,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),

                        SizedBox(height: h * 0.05),

                        // Indicador de páginas
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: onboardingData.length,
                          effect: WormEffect(
                            dotColor: Colors.grey.shade300,
                            activeDotColor: const Color(0xFF6A1B9A),
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                          ),
                        ),

                        SizedBox(height: h * 0.05),

                        // Título abaixo
                        Text(
                          data['headline'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4527A0),
                          ),
                        ),
                        SizedBox(height: h * 0.015),

                        // Descrição
                        Text(
                          data['description'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: w * 0.035,
                            color: const Color(0xFF7E7E8F),
                            height: 1.4,
                          ),
                        ),

                        SizedBox(height: h * 0.05),

                        // Botão
                        _currentPage == onboardingData.length - 1
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6A1B9A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.2,
                                    vertical: h * 0.018,
                                  ),
                                ),
                                child: Text(
                                  'Começar',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: w * 0.04,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  _pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6A1B9A),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.all(w * 0.025),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
