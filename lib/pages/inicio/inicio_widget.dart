import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inicio_model.dart';
export 'inicio_model.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});

  static String routeName = 'inicio';
  static String routePath = '/inicio';

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  late InicioModel _model;
  int _currentTabIndex = 0;
  String _galleryFilter = 'all';

  // Hero cut selector index (0 to 3)
  int _heroCutIndex = 0;

  // Booking state
  Map<String, dynamic>? _bookingService;
  String _bookingBarber = 'Qualquer Barbeiro';
  String _bookingDate = 'Hoje';
  String _bookingTime = '14:00';
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();

  // Local sample appointments list
  final List<Map<String, dynamic>> _myAppointments = [
    {
      'id': 'DELA-8942',
      'service': 'Combo Delacruz (Cabelo + Barba)',
      'barber': 'Danilo Delacruz',
      'date': 'Sexta-feira, 17/10',
      'time': '15:30',
      'price': r'R$ 60,00',
      'status': 'Confirmado',
    },
  ];

  // Official cuts from PW2026 website
  final List<Map<String, dynamic>> _cuts = [
    {
      'id': 'cut-1',
      'title': 'Low Fade com Linhas Freestyle',
      'barber': 'Heitor Pontes',
      'badge': 'Destaque da Barbearia',
      'category': 'freestyle',
      'image': 'assets/images/cortes/tribal_wave_fade.jpg',
      'likes': 184,
      'description': 'Degradê baixo na navalha com desenho autoral de linhas geométricas e acabamento milimétrico.',
      'tech_specs': 'Máquina shaver + navalhete feather. Finalizado com pomada matte fixação forte.',
      'recommended_for': 'Homens que buscam originalidade, ousadia e definição impecável na lateral.',
    },
    {
      'id': 'cut-2',
      'title': 'Mid Fade com Risco Raio em Cachos',
      'barber': 'Heitor Pontes',
      'badge': 'Cachos & Freestyle',
      'category': 'cachos',
      'image': 'assets/images/cortes/freestyle_raio_curls.jpg',
      'likes': 156,
      'description': 'Disfarçado intermediário preservando o volume natural dos cachos com detalhe de risco em raio.',
      'tech_specs': 'Graduação pente 0.5 a 2. Ativador de cachos com óleo de argan e difusor.',
      'recommended_for': 'Cabelos cacheados e crespos que querem destaque nas texturas superiores.',
    },
    {
      'id': 'cut-3',
      'title': 'Taper Fade com Acabamento Preciso',
      'barber': 'Heitor Pontes',
      'badge': 'Pezinho & Barba',
      'category': 'fade',
      'image': 'assets/images/cortes/taper_fade_delacruz.jpg',
      'likes': 198,
      'description': 'Disfarçado sutil apenas nas têmporas e nuca, mantendo as laterais limpas e o pezinho desenhado.',
      'tech_specs': 'Zero taper clipper over comb, alinhamento navalhado e toalha quente na nuca.',
      'recommended_for': 'Visual corporativo e moderno que dura mais tempo sem perder a elegância.',
    },
    {
      'id': 'cut-4',
      'title': 'Taper Fade em Cachos com Luzes',
      'barber': 'Danilo Delacruz',
      'badge': 'Luzes Platinadas',
      'category': 'cachos',
      'image': 'assets/images/cortes/cachos_luzes_taper.jpg',
      'likes': 142,
      'description': 'Combinação marcante de mechas loiras/platinadas no topo com disfarçado suave nas laterais.',
      'tech_specs': 'Descoloração controlada com plex protetor, matização perolada e hidratação profunda.',
      'recommended_for': 'Homens que desejam visual de destaque com contraste de cor e corte moderno.',
    },
    {
      'id': 'cut-5',
      'title': 'Low Fade Texturizado',
      'barber': 'Danilo Delacruz',
      'badge': 'Textura & Movimento',
      'category': 'fade',
      'image': 'assets/images/cortes/low_fade_texturizado.jpg',
      'likes': 167,
      'description': 'Degradê baixo suave com topo cortado na tesoura criando mechas texturizadas e desconectadas.',
      'tech_specs': 'Tesoura dentada para texturização, navalha na nuca e pó texturizador volumão.',
      'recommended_for': 'Estilo prático pro dia a dia, fácil de pentear com as mãos.',
    },
    {
      'id': 'cut-6',
      'title': 'Mid Fade French Crop',
      'barber': 'Heitor Pontes',
      'badge': 'Tendência Europeia',
      'category': 'fade',
      'image': 'assets/images/cortes/mid_fade_crop.jpg',
      'likes': 139,
      'description': 'Franja reta milimétrica, laterais em degradê médio limpo e topo despojado em camadas.',
      'tech_specs': 'Guia reta frontal na navalha, desfiado superior com tesoura fio laser.',
      'recommended_for': 'Visual urbano e descolado com forte presença estética frontal.',
    },
  ];

  // Official Services from PW2026 website
  final List<Map<String, dynamic>> _services = [
    {
      'id': '1',
      'name': 'Corte Degradê / Fade',
      'category': 'Cabelo',
      'price': 35.0,
      'duration': '30 min',
      'description': 'Degradê na régua (Low, Mid, High ou Taper Fade) com navalha e finalização.',
      'tag': 'Mais Pedido',
    },
    {
      'id': '2',
      'name': 'Barba Completa com Toalha Quente',
      'category': 'Barba',
      'price': 30.0,
      'duration': '25 min',
      'description': 'Toalha aromática aquecida, óleos essenciais, massagem facial e navalha de precisão.',
      'tag': 'Barboterapia',
    },
    {
      'id': '3',
      'name': 'Combo Delacruz (Cabelo + Barba)',
      'category': 'Combos',
      'price': 60.0,
      'duration': '50 min',
      'description': 'A experiência completa: corte degradê autoral + barba na toalha quente com desconto.',
      'tag': 'Combo VIP',
    },
    {
      'id': '4',
      'name': 'Pezinho & Acabamento na Navalha',
      'category': 'Cabelo',
      'price': 15.0,
      'duration': '15 min',
      'description': 'Alinhamento dos contornos das têmporas, nuca e costeletas na navalha.',
      'tag': 'Rápido',
    },
    {
      'id': '5',
      'name': 'Nevou / Platinado Global',
      'category': 'Química',
      'price': 90.0,
      'duration': '1h 30m',
      'description': 'Descoloração técnica com produto importado sem ardência no couro cabeludo.',
      'tag': 'Platinado',
    },
    {
      'id': '6',
      'name': 'Design de Sobrancelha na Navalha',
      'category': 'Tratamentos',
      'price': 15.0,
      'duration': '10 min',
      'description': 'Simetria facial com desenho e limpeza dos fios com precisão cirúrgica.',
      'tag': 'Acabamento',
    },
    {
      'id': '7',
      'name': 'Freestyle / Desenho Autoral',
      'category': 'Cabelo',
      'price': 25.0,
      'duration': '20 min',
      'description': 'Riscos, raios e linhas artísticas personalizadas na lateral do cabelo.',
      'tag': 'Autoral',
    },
  ];

  // Official Barbers from PW2026 website
  final List<Map<String, dynamic>> _barbers = [
    {
      'name': 'Danilo Delacruz',
      'role': 'Master Barber & Fundador',
      'specialty': 'Taper Fade, Luzes & Barboterapia',
      'description': 'Fundador da Barbearia Delacruz e instrutor da Delacruz Academy, especialista com mais de 8 anos de navalha.',
      'image': 'assets/images/danilo_avatar.jpg',
      'rating': 4.9,
      'reviews': 420,
    },
    {
      'name': 'Heitor Pontes',
      'role': 'Barbeiro Especialista',
      'specialty': 'Degradês Modernos & Desenhos Freestyle',
      'description': 'Especialista em Low Fade, French Crop e desenhos freestyle autorais que ditam tendência.',
      'image': 'assets/images/heitor_avatar.jpg',
      'rating': 5.0,
      'reviews': 315,
    },
  ];

  // Official Academy Students from PW2026 website
  final List<Map<String, dynamic>> _academyStudents = [
    {
      'name': 'Bruno Madureira e Silva',
      'desc': 'Certificado assinado pelo Prof. Danilo Delacruz',
      'badge': 'Formado com Sucesso',
      'image': 'assets/images/cursos/aluno_bruno.jpg',
    },
    {
      'name': 'Yasmim da Silva Vieira',
      'desc': 'Especialização em cortes, barba e sobrancelha',
      'badge': 'Destaque Prático',
      'image': 'assets/images/cursos/aluno_yasmim.jpg',
    },
    {
      'name': 'Lucas José Perdomo Soares',
      'desc': 'Barbeiro profissional capacitado na bancada',
      'badge': 'Formado com Sucesso',
      'image': 'assets/images/cursos/aluno_lucas.jpg',
    },
    {
      'name': 'Pedro Henrique Ferreira',
      'desc': 'Conclusão e capacitação prática Delacruz',
      'badge': 'Formado com Sucesso',
      'image': 'assets/images/cursos/aluno_pedro.jpg',
    },
    {
      'name': 'João Paulo Alves',
      'desc': 'Formação completa em cortes modernos e barba',
      'badge': 'Formado com Sucesso',
      'image': 'assets/images/cursos/aluno_joaopaulo.jpg',
    },
  ];

  final List<String> _availableTimes = [
    '08:00', '08:45', '09:30', '10:15', '11:00',
    '13:30', '14:15', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '20:45'
  ];

  final List<String> _availableDates = [
    'Hoje', 'Amanhã', 'Quinta', 'Sexta', 'Sábado'
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InicioModel());
    _bookingService = _services.first;
    _clientNameController.text = currentUserDisplayName.isNotEmpty ? currentUserDisplayName : '';
  }

  @override
  void dispose() {
    _model.dispose();
    _clientNameController.dispose();
    _clientPhoneController.dispose();
    super.dispose();
  }

  void _startBooking(Map<String, dynamic> service, {String? preferredBarber}) {
    setState(() {
      _bookingService = service;
      if (preferredBarber != null) {
        _bookingBarber = preferredBarber;
      }
      _currentTabIndex = 1; // Go to Agendar tab
    });
  }

  void _showCutDetailModal(Map<String, dynamic> cut) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final theme = FlutterFlowTheme.of(context);
        return Container(
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
            border: Border.all(color: theme.primary.withValues(alpha: 0.3)),
          ),
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 48.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: theme.alternate,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Cut Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    cut['image'],
                    width: double.infinity,
                    height: 280.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: theme.primary,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        cut['badge'],
                        style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.w800, color: Colors.black),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red, size: 18.0),
                        const SizedBox(width: 4.0),
                        Text('${cut['likes']} curtidas', style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),

                Text(
                  cut['title'],
                  style: GoogleFonts.cinzel(fontSize: 20.0, fontWeight: FontWeight.w800, color: theme.primaryText),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Corte executado por ${cut['barber']}',
                  style: GoogleFonts.inter(fontSize: 13.0, color: theme.primary, fontWeight: FontWeight.w600),
                ),
                const Divider(height: 24.0),

                Text('SOBRE O ESTILO', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.secondaryText)),
                const SizedBox(height: 4.0),
                Text(cut['description'], style: GoogleFonts.inter(fontSize: 13.0, color: theme.primaryText)),
                const SizedBox(height: 14.0),

                Text('FICHA TÉCNICA', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.secondaryText)),
                const SizedBox(height: 4.0),
                Text(cut['tech_specs'], style: GoogleFonts.inter(fontSize: 13.0, color: theme.secondaryText)),
                const SizedBox(height: 20.0),

                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      _startBooking(_services.first, preferredBarber: cut['barber']);
                    },
                    icon: const Icon(Icons.event_available_rounded, color: Colors.black),
                    label: Text('QUERO ESSE CORTE NA MINHA CABEÇA', style: GoogleFonts.interTight(fontSize: 13.0, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmBooking() async {
    final clientName = _clientNameController.text.trim().isNotEmpty
        ? _clientNameController.text.trim()
        : (currentUserDisplayName.isNotEmpty ? currentUserDisplayName : 'Cliente Delacruz');

    final serviceName = _bookingService?['name'] ?? 'Corte Degradê / Fade';
    final servicePrice = 'R\$ ${(_bookingService?['price'] as double? ?? 35.0).toStringAsFixed(2)}';

    try {
      await AtividadeRecord.collection.add(createAtividadeRecordData(
        titulo: 'Agendamento: $serviceName',
        descricao: 'Cliente: $clientName | Barbeiro: $_bookingBarber | Data: $_bookingDate às $_bookingTime | Valor: $servicePrice',
        criadoEm: DateTime.now(),
      ));
    } catch (_) {}

    final newAppointment = {
      'id': 'DELA-${2000 + _myAppointments.length + 1}',
      'service': serviceName,
      'barber': _bookingBarber,
      'date': _bookingDate,
      'time': _bookingTime,
      'price': servicePrice,
      'status': 'Confirmado',
    };

    setState(() {
      _myAppointments.insert(0, newAppointment);
    });

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (dialogCtx) {
        final theme = FlutterFlowTheme.of(context);
        return AlertDialog(
          backgroundColor: theme.secondaryBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 65.0,
                height: 65.0,
                decoration: BoxDecoration(
                  color: theme.success.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle_rounded, color: theme.success, size: 44.0),
              ),
              const SizedBox(height: 14.0),
              Text(
                'Agendamento Confirmado!',
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(fontSize: 18.0, fontWeight: FontWeight.w800, color: theme.primaryText),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Seu horário na Delacruz Barber está garantido na régua!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 13.0, color: theme.secondaryText),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: theme.primaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _dialogRow('Serviço', serviceName, theme),
                    const Divider(height: 12.0),
                    _dialogRow('Barbeiro', _bookingBarber, theme),
                    const Divider(height: 12.0),
                    _dialogRow('Data & Hora', '$_bookingDate às $_bookingTime', theme),
                    const Divider(height: 12.0),
                    _dialogRow('Valor', servicePrice, theme, isBold: true),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 44.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              onPressed: () {
                Navigator.pop(dialogCtx);
                setState(() => _currentTabIndex = 4); // Go to Meus Cortes
              },
              child: const Text('VER MEUS HORÁRIOS', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogRow(String label, String value, FlutterFlowTheme theme, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.inter(
              fontSize: 12.0,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? theme.primary : theme.primaryText,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isUserLoggedIn = loggedIn;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: Column(
            children: [
              // Delacruz Top Bar
              _buildTopBar(theme, isUserLoggedIn),

              // Active Tab Content
              Expanded(
                child: IndexedStack(
                  index: _currentTabIndex,
                  children: [
                    _buildHomeTab(theme),
                    _buildBookingTab(theme),
                    _buildCutsGalleryTab(theme),
                    _buildClubAndAcademyTab(theme),
                    _buildAppointmentsAndProfileTab(theme, isUserLoggedIn),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(theme),
      ),
    );
  }

  Widget _buildTopBar(FlutterFlowTheme theme, bool isUserLoggedIn) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(bottom: BorderSide(color: theme.alternate, width: 1.0)),
      ),
      child: Row(
        children: [
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primary, const Color(0xFF9A6B1F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.content_cut_rounded, color: Colors.black87, size: 22.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'DELACRUZ BARBER',
                  style: GoogleFonts.cinzel(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: theme.primaryText,
                  ),
                ),
                Text(
                  'Seu estilo começa aqui • 08h às 21h30',
                  style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText),
                ),
              ],
            ),
          ),
          // Theme Toggle
          IconButton(
            tooltip: 'Alternar Tema',
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: theme.primary,
              size: 20.0,
            ),
            onPressed: () {
              final newMode = Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              MyApp.of(context).setThemeMode(newMode);
            },
          ),
          if (!isUserLoggedIn)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                minimumSize: const Size(0, 32),
              ),
              onPressed: () {
                context.pushNamed(HomePageCopyWidget.routeName);
              },
              child: Text('LOGIN', style: GoogleFonts.interTight(fontSize: 11.0, fontWeight: FontWeight.bold)),
            )
          else
            IconButton(
              icon: Icon(Icons.account_circle_rounded, color: theme.primary, size: 26.0),
              onPressed: () => setState(() => _currentTabIndex = 4),
            ),
        ],
      ),
    );
  }

  // TAB 1: INÍCIO (PW2026 HERO & SHOWCASE)
  Widget _buildHomeTab(FlutterFlowTheme theme) {
    final activeHeroCut = _cuts[_heroCutIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HERO SHOWCASE WITH REAL CUT SWITCHER (PW2026 Style)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.secondaryBackground,
                  theme.primaryBackground,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.content_cut, size: 14.0, color: Colors.black),
                      const SizedBox(width: 6.0),
                      Text(
                        'DELACRUZ BARBER • CORTES DE ALTO PADRÃO',
                        style: GoogleFonts.inter(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),

                Text(
                  'Estilo, Arte & Precisão',
                  style: GoogleFonts.cinzel(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    color: theme.primaryText,
                    height: 1.2,
                  ),
                ),
                Text(
                  'para o Homem Moderno',
                  style: GoogleFonts.cinzel(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: theme.primary,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Degradês marcantes, pezinhos na navalha, desenhos autorais e barba completa com toalha quente. Experiência premium com Danilo Delacruz & Heitor Pontes.',
                  style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText, height: 1.4),
                ),
                const SizedBox(height: 16.0),

                // Main Interactive Cut Card
                GestureDetector(
                  onTap: () => _showCutDetailModal(activeHeroCut),
                  child: Container(
                    height: 280.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 15.0,
                          offset: const Offset(0.0, 8.0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            activeHeroCut['image'],
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.9),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 14.0,
                            left: 14.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: theme.primary,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                activeHeroCut['badge'],
                                style: GoogleFonts.inter(fontSize: 10.0, fontWeight: FontWeight.w800, color: Colors.black),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 14.0,
                            left: 14.0,
                            right: 14.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activeHeroCut['title'],
                                  style: GoogleFonts.cinzel(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 2.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Por ${activeHeroCut['barber']}',
                                      style: GoogleFonts.inter(fontSize: 12.0, color: theme.primary, fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(6.0),
                                        border: Border.all(color: theme.primary.withValues(alpha: 0.5)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.zoom_in, color: theme.primary, size: 14.0),
                                          const SizedBox(width: 4.0),
                                          Text('Ver Detalhes', style: TextStyle(color: theme.primary, fontSize: 10.0)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),

                // Thumb Selector Row (4 Styles from PW2026 site)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alternar corte em destaque:', style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText)),
                    Text('4 estilos reais', style: GoogleFonts.inter(fontSize: 11.0, color: theme.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: List.generate(4, (index) {
                    final cut = _cuts[index];
                    final isSelected = _heroCutIndex == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _heroCutIndex = index),
                        child: Container(
                          margin: EdgeInsets.only(right: index < 3 ? 8.0 : 0.0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: isSelected ? theme.primary : theme.alternate,
                              width: isSelected ? 2.0 : 1.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(cut['image'], width: double.infinity, height: 50.0, fit: BoxFit.cover),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                cut['title'].split(' ').take(2).join(' '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontSize: 9.0,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? theme.primary : theme.primaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20.0),

          // 2. QUICK CTA BUTTONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                    ),
                    onPressed: () => setState(() => _currentTabIndex = 1),
                    icon: const Icon(Icons.event_available_rounded, color: Colors.black, size: 20.0),
                    label: Text(
                      'AGENDAR AGORA',
                      style: GoogleFonts.interTight(fontSize: 13.0, fontWeight: FontWeight.w800, letterSpacing: 0.8),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.primary),
                    foregroundColor: theme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                  ),
                  onPressed: () => setState(() => _currentTabIndex = 2),
                  icon: const Icon(Icons.photo_library_outlined, size: 18.0),
                  label: const Text('FOTOS', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24.0),

          // 3. BARBERS SECTION (Danilo & Heitor)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'MESTRES BARBEIROS',
              style: GoogleFonts.cinzel(fontSize: 16.0, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: theme.primaryText),
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: _barbers.map((barber) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: barber == _barbers.first ? 10.0 : 0.0),
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: theme.alternate),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 36.0,
                          backgroundImage: AssetImage(barber['image']),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          barber['name'],
                          style: GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.bold, color: theme.primaryText),
                        ),
                        Text(
                          barber['role'],
                          style: GoogleFonts.inter(fontSize: 10.0, color: theme.primary, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          barber['specialty'],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(fontSize: 10.0, color: theme.secondaryText),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.secondaryBackground,
                            foregroundColor: theme.primary,
                            side: BorderSide(color: theme.primary),
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                            minimumSize: const Size(double.infinity, 30.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () => _startBooking(_services.first, preferredBarber: barber['name']),
                          child: Text('Agendar com ${barber['name'].split(' ')[0]}', style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 28.0),

          // 4. SERVICES LIST (Official PW2026 Prices)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SERVIÇOS EM DESTAQUE',
                  style: GoogleFonts.cinzel(fontSize: 16.0, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: theme.primaryText),
                ),
                Text('${_services.length} opções', style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _services.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
            itemBuilder: (ctx, index) {
              final service = _services[index];
              return Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: theme.alternate),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: theme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(Icons.content_cut_rounded, color: theme.primary, size: 20.0),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(service['name'], style: GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.bold, color: theme.primaryText)),
                              const SizedBox(width: 6.0),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: theme.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(service['tag'], style: GoogleFonts.inter(fontSize: 9.0, fontWeight: FontWeight.bold, color: theme.primary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2.0),
                          Text(service['description'], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText)),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 12.0, color: theme.secondaryText),
                              const SizedBox(width: 4.0),
                              Text(service['duration'], style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText)),
                              const SizedBox(width: 12.0),
                              Text('R\$ ${(service['price'] as double).toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w800, color: theme.primary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primary,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        minimumSize: const Size(0, 32),
                      ),
                      onPressed: () => _startBooking(service),
                      child: const Text('Agendar', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 28.0),

          // 5. SALON EXPERIENCE & DIFERENCIAIS (From PW2026 site)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'EXPERIÊNCIA DELACRUZ',
              style: GoogleFonts.cinzel(fontSize: 16.0, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: theme.primaryText),
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.4,
              children: [
                _amenityCard(Icons.sports_bar_outlined, 'Bebidas Cortesia', 'Cerveja trincando, Coca-Cola e café expresso.', theme),
                _amenityCard(Icons.tv_rounded, 'TV & Música', 'Smart TV com clipes e som na resenha.', theme),
                _amenityCard(Icons.wifi_rounded, 'Wi-Fi & Bateria', 'Fibra ultrarrápida e carregador por indução.', theme),
                _amenityCard(Icons.ac_unit_rounded, '100% Climatizado', 'Conforto térmico e poltronas reclináveis.', theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amenityCard(IconData icon, String title, String desc, FlutterFlowTheme theme) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: theme.alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: theme.primary, size: 22.0),
          const SizedBox(height: 6.0),
          Text(title, style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.bold, color: theme.primaryText)),
          const SizedBox(height: 2.0),
          Text(desc, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 10.0, color: theme.secondaryText)),
        ],
      ),
    );
  }

  // TAB 2: AGENDAMENTO ONLINE (Real Booking Flow)
  Widget _buildBookingTab(FlutterFlowTheme theme) {
    final price = _bookingService != null
        ? 'R\$ ${(_bookingService!['price'] as double).toStringAsFixed(2)}'
        : 'R\$ 0,00';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AGENDAR HORÁRIO',
            style: GoogleFonts.cinzel(fontSize: 20.0, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: theme.primaryText),
          ),
          Text('Reserve seu atendimento na cadeira da Delacruz Barber', style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
          const SizedBox(height: 20.0),

          // 1. Serviço
          Text('1. SERVIÇO DESEJADO', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.primary, letterSpacing: 1.0)),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: theme.alternate),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Map<String, dynamic>>(
                value: _bookingService,
                isExpanded: true,
                dropdownColor: theme.secondaryBackground,
                items: _services.map((s) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: s,
                    child: Text('${s['name']} — R\$ ${(s['price'] as double).toStringAsFixed(2)} (${s['duration']})', style: theme.bodyMedium),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _bookingService = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 18.0),

          // 2. Barbeiro
          Text('2. PROFISSIONAL', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.primary, letterSpacing: 1.0)),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _choicePill('Qualquer Barbeiro', _bookingBarber == 'Qualquer Barbeiro', () => setState(() => _bookingBarber = 'Qualquer Barbeiro'), theme),
              const SizedBox(width: 8.0),
              _choicePill('Danilo Delacruz', _bookingBarber == 'Danilo Delacruz', () => setState(() => _bookingBarber = 'Danilo Delacruz'), theme),
              const SizedBox(width: 8.0),
              _choicePill('Heitor Pontes', _bookingBarber == 'Heitor Pontes', () => setState(() => _bookingBarber = 'Heitor Pontes'), theme),
            ],
          ),
          const SizedBox(height: 18.0),

          // 3. Dia
          Text('3. DATA DO ATENDIMENTO', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.primary, letterSpacing: 1.0)),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _availableDates.map((date) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _choicePill(date, _bookingDate == date, () => setState(() => _bookingDate = date), theme),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 18.0),

          // 4. Horário (PW2026: 08:00 às 21:30)
          Text('4. HORÁRIO DISPONÍVEL (08:00 - 21:30)', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.primary, letterSpacing: 1.0)),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _availableTimes.map((time) {
              return _choicePill(time, _bookingTime == time, () => setState(() => _bookingTime = time), theme);
            }).toList(),
          ),
          const SizedBox(height: 22.0),

          // Dados do cliente
          Text('SEUS DADOS', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.primary, letterSpacing: 1.0)),
          const SizedBox(height: 8.0),
          TextField(
            controller: _clientNameController,
            style: theme.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Nome do Cliente',
              prefixIcon: const Icon(Icons.person_outline),
              filled: true,
              fillColor: theme.secondaryBackground,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _clientPhoneController,
            keyboardType: TextInputType.phone,
            style: theme.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Telefone / WhatsApp',
              prefixIcon: const Icon(Icons.phone_outlined),
              filled: true,
              fillColor: theme.secondaryBackground,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          const SizedBox(height: 24.0),

          // Resumo & Confirmação
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: theme.primary, width: 1.5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:', style: GoogleFonts.inter(fontSize: 14.0, color: theme.secondaryText)),
                    Text(price, style: GoogleFonts.inter(fontSize: 22.0, fontWeight: FontWeight.w900, color: theme.primary)),
                  ],
                ),
                const SizedBox(height: 14.0),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    onPressed: _confirmBooking,
                    child: Text('CONFIRMAR HORÁRIO NA RÉGUA', style: GoogleFonts.interTight(fontSize: 13.0, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _choicePill(String label, bool isSelected, VoidCallback onTap, FlutterFlowTheme theme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? theme.primary : theme.secondaryBackground,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: isSelected ? theme.primary : theme.alternate),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.black : theme.primaryText,
          ),
        ),
      ),
    );
  }

  // TAB 3: GALERIA OFICIAL DE CORTES (Lookbook)
  Widget _buildCutsGalleryTab(FlutterFlowTheme theme) {
    final filteredCuts = _galleryFilter == 'all'
        ? _cuts
        : _cuts.where((c) => c['category'] == _galleryFilter || c['barber'].toLowerCase().contains(_galleryFilter)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GALERIA DE CORTES',
            style: GoogleFonts.cinzel(fontSize: 20.0, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: theme.primaryText),
          ),
          Text('Trabalhos reais fotografados no espaço Delacruz Barber', style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
          const SizedBox(height: 14.0),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _galleryFilterChip('all', 'Todos os Cortes', theme),
                _galleryFilterChip('fade', 'Degradê / Fade', theme),
                _galleryFilterChip('cachos', 'Cachos & Texturas', theme),
                _galleryFilterChip('freestyle', 'Riscos & Freestyle', theme),
                _galleryFilterChip('danilo', 'Danilo Delacruz', theme),
                _galleryFilterChip('heitor', 'Heitor Pontes', theme),
              ],
            ),
          ),
          const SizedBox(height: 16.0),

          // Grid of Cuts Cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredCuts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (ctx, index) {
              final cut = filteredCuts[index];
              return GestureDetector(
                onTap: () => _showCutDetailModal(cut),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: theme.alternate),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cut Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                        child: Image.asset(
                          cut['image'],
                          width: double.infinity,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cut['badge'],
                              style: GoogleFonts.inter(fontSize: 9.0, fontWeight: FontWeight.bold, color: theme.primary),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              cut['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.bold, color: theme.primaryText),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cut['barber'].split(' ')[0],
                                  style: GoogleFonts.inter(fontSize: 10.0, color: theme.secondaryText),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.favorite, size: 12.0, color: Colors.red),
                                    const SizedBox(width: 3.0),
                                    Text('${cut['likes']}', style: GoogleFonts.inter(fontSize: 10.0, color: theme.secondaryText)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _galleryFilterChip(String key, String label, FlutterFlowTheme theme) {
    final isSelected = _galleryFilter == key;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _galleryFilter = key),
        selectedColor: theme.primary,
        backgroundColor: theme.secondaryBackground,
        labelStyle: GoogleFonts.inter(
          fontSize: 11.0,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? Colors.black : theme.primaryText,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: isSelected ? theme.primary : theme.alternate),
        ),
      ),
    );
  }

  // TAB 4: DELACRUZ CLUB VIP & DELACRUZ ACADEMY
  Widget _buildClubAndAcademyTab(FlutterFlowTheme theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DELACRUZ CLUB VIP SECTION
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E252D), Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: theme.primary.withValues(alpha: 0.5), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.workspace_premium_rounded, color: theme.primary, size: 24.0),
                        const SizedBox(width: 8.0),
                        Text(
                          'DELACRUZ CLUB VIP',
                          style: GoogleFonts.cinzel(fontSize: 14.0, fontWeight: FontWeight.bold, color: theme.primary),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(color: theme.primary, borderRadius: BorderRadius.circular(6.0)),
                      child: const Text('ASSINATURA', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w900, color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Seu corte sempre em dia com planos mensais exclusivos e agendamento prioritário.',
                  style: GoogleFonts.inter(fontSize: 12.0, color: Colors.white70),
                ),
                const SizedBox(height: 16.0),

                // Plan 1: Silver
                _planCard('Delacruz Silver', r'R$ 69,90', '2 cortes por mês + Agendamento prioritário', false, theme),
                const SizedBox(height: 10.0),

                // Plan 2: Gold VIP
                _planCard('Delacruz Gold VIP', r'R$ 139,90', '4 cortes + Barba inclusa + Bebida cortesia', true, theme),
              ],
            ),
          ),

          const SizedBox(height: 28.0),

          // DELACRUZ ACADEMY (Curso de Formação Profissional)
          Text(
            'DELACRUZ ACADEMY',
            style: GoogleFonts.cinzel(fontSize: 18.0, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: theme.primaryText),
          ),
          Text('Formação de Barbeiro Iniciante ao Profissional com Danilo Delacruz', style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
          const SizedBox(height: 14.0),

          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: theme.alternate),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Investimento:', style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText)),
                        Text(r'R$ 1.500,00', style: GoogleFonts.cinzel(fontSize: 22.0, fontWeight: FontWeight.w900, color: theme.primary)),
                        Text('em até 12x no cartão ou Pix', style: GoogleFonts.inter(fontSize: 10.0, color: theme.success, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: theme.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.school_rounded, color: theme.primary, size: 28.0),
                    ),
                  ],
                ),
                const Divider(height: 24.0),

                Text('O que você domina na bancada:', style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.bold, color: theme.primaryText)),
                const SizedBox(height: 8.0),
                _bulletItem('Cortes & Degradês na Régua (Low, Mid, High Fade e Taper)', theme),
                _bulletItem('Barboterapia com Toalha Quente e Navalha', theme),
                _bulletItem('Nevou e Platinado Global sem Ardência', theme),
                _bulletItem('Design e Alinhamento de Sobrancelha', theme),
                _bulletItem('Certificado Reconhecido assinado por Danilo Delacruz', theme),
                const SizedBox(height: 16.0),

                // Alunos Formados
                Text('Alunos Formados com Sucesso:', style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.bold, color: theme.primaryText)),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 110.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _academyStudents.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                    itemBuilder: (ctx, index) {
                      final student = _academyStudents[index];
                      return Container(
                        width: 110.0,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: theme.primaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 24.0,
                              backgroundImage: AssetImage(student['image']),
                            ),
                            const SizedBox(height: 6.0),
                            Text(
                              student['name'].split(' ')[0],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.primaryText),
                            ),
                            Text('Certificado', style: GoogleFonts.inter(fontSize: 9.0, color: theme.primary)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _planCard(String title, String price, String perks, bool isHighlight, FlutterFlowTheme theme) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isHighlight ? theme.primary.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: isHighlight ? theme.primary : Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white)),
                    if (isHighlight) ...[
                      const SizedBox(width: 6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(color: theme.primary, borderRadius: BorderRadius.circular(4.0)),
                        child: const Text('RECOMENDADO', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w900, color: Colors.black)),
                      ),
                    ],
                  ],
                ),
                Text(perks, style: GoogleFonts.inter(fontSize: 10.0, color: Colors.white70)),
              ],
            ),
          ),
          Text(price, style: GoogleFonts.inter(fontSize: 15.0, fontWeight: FontWeight.w900, color: theme.primary)),
        ],
      ),
    );
  }

  Widget _bulletItem(String text, FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, color: theme.primary, size: 14.0),
          const SizedBox(width: 8.0),
          Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText))),
        ],
      ),
    );
  }

  // TAB 5: MEUS AGENDAMENTOS & PERFIL
  Widget _buildAppointmentsAndProfileTab(FlutterFlowTheme theme, bool isUserLoggedIn) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: theme.alternate),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32.0,
                  backgroundColor: theme.primary,
                  child: const Icon(Icons.person, color: Colors.black, size: 34.0),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isUserLoggedIn
                            ? (currentUserDisplayName.isNotEmpty ? currentUserDisplayName : 'Cliente Delacruz')
                            : 'Modo Visitante',
                        style: GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.bold, color: theme.primaryText),
                      ),
                      Text(
                        isUserLoggedIn ? (currentUserEmail.isNotEmpty ? currentUserEmail : 'Cadastrado') : 'Faça login para salvar seus cortes',
                        style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                        decoration: BoxDecoration(color: theme.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6.0)),
                        child: Text(
                          isUserLoggedIn ? 'MEMBRO VIP DELACRUZ' : 'VISITANTE',
                          style: GoogleFonts.inter(fontSize: 9.0, fontWeight: FontWeight.w800, color: theme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // Meus Horários Marcados
          Text('MEUS AGENDAMENTOS', style: GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.bold, color: theme.primary, letterSpacing: 1.0)),
          const SizedBox(height: 10.0),
          if (_myAppointments.isEmpty)
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Center(
                child: Text('Nenhum agendamento ativo. Agende seu horário!', style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
              ),
            )
          else
            ..._myAppointments.map((apt) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: theme.alternate),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(apt['id'], style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                          decoration: BoxDecoration(color: theme.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6.0)),
                          child: Text(apt['status'], style: GoogleFonts.inter(fontSize: 10.0, fontWeight: FontWeight.bold, color: theme.success)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Text(apt['service'], style: GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.bold, color: theme.primaryText)),
                    Text('Barbeiro: ${apt['barber']}', style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText)),
                    const Divider(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${apt['date']} às ${apt['time']}', style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.bold, color: theme.primary)),
                        Text(apt['price'], style: GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w900, color: theme.primaryText)),
                      ],
                    ),
                  ],
                ),
              );
            }),

          const SizedBox(height: 20.0),

          // Admin Link: Cadastrar Serviço
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: theme.alternate)),
            tileColor: theme.secondaryBackground,
            leading: Icon(Icons.add_business_rounded, color: theme.primary),
            title: Text('Cadastrar Novo Serviço / Atividade', style: GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.bold, color: theme.primaryText)),
            subtitle: Text('Área do barbeiro e administração', style: GoogleFonts.inter(fontSize: 11.0, color: theme.secondaryText)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AtividadeCreateWidget.routeName),
          ),
          const SizedBox(height: 12.0),

          // Logout / Login
          if (isUserLoggedIn)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: BorderSide(color: theme.error)),
                onPressed: () async {
                  await authManager.signOut();
                  if (mounted) context.goNamed(InicioWidget.routeName);
                },
                child: Text('Sair da Conta', style: TextStyle(color: theme.error)),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: theme.primary, foregroundColor: Colors.black),
                onPressed: () => context.pushNamed(HomePageCopyWidget.routeName),
                child: const Text('FAZER LOGIN / CRIAR CONTA'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(FlutterFlowTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(top: BorderSide(color: theme.alternate, width: 1.0)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (idx) => setState(() => _currentTabIndex = idx),
        backgroundColor: theme.secondaryBackground,
        selectedItemColor: theme.primary,
        unselectedItemColor: theme.secondaryText,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.inter(fontSize: 10.0, fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 10.0, fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today_rounded), label: 'Agendar'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library_outlined), activeIcon: Icon(Icons.photo_library_rounded), label: 'Cortes'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium_outlined), activeIcon: Icon(Icons.workspace_premium_rounded), label: 'VIP/Curso'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
