import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  bool _isLoading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.nomeTextController ??= TextEditingController();
    _model.nomeFocusNode ??= FocusNode();

    _model.eMailTextController ??= TextEditingController();
    _model.eMailFocusNode ??= FocusNode();

    _model.senhaTextController ??= TextEditingController();
    _model.senhaFocusNode ??= FocusNode();

    _model.senhaRTextController ??= TextEditingController();
    _model.senhaRFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final nome = _model.nomeTextController?.text.trim() ?? '';
    final email = _model.eMailTextController?.text.trim() ?? '';
    final senha = _model.senhaTextController?.text ?? '';
    final senhaR = _model.senhaRTextController?.text ?? '';

    // Validation
    if (nome.isEmpty || email.isEmpty || senha.isEmpty || senhaR.isEmpty) {
      _showWarning('Por favor, preencha todos os campos para continuar.');
      return;
    }

    if (nome.length < 3) {
      _showWarning('O nome deve conter pelo menos 3 caracteres.');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showWarning('Por favor, insira um e-mail válido.');
      return;
    }

    if (senha.length < 6) {
      _showWarning('A senha deve ter no mínimo 6 caracteres.');
      return;
    }

    if (senha != senhaR) {
      _showWarning('As senhas não coincidem. Digite novamente.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      GoRouter.of(context).prepareAuthEvent();
      final user = await authManager.createAccountWithEmail(
        context,
        email,
        senha,
      );

      if (!mounted) return;

      if (user != null) {
        // Save display name if possible
        await FirebaseAuth.instance.currentUser?.updateDisplayName(nome).catchError((_) {});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 10.0),
                Expanded(child: Text('Conta criada com sucesso! Seja bem-vindo à Delacruz.')),
              ],
            ),
            backgroundColor: FlutterFlowTheme.of(context).success,
            behavior: SnackBarBehavior.floating,
          ),
        );

        _model.nomeTextController?.clear();
        _model.eMailTextController?.clear();
        _model.senhaTextController?.clear();
        _model.senhaRTextController?.clear();

        context.goNamedAuth(InicioWidget.routeName, context.mounted);
      } else {
        _showWarning('Não foi possível criar a conta. Verifique os dados inseridos.');
      }
    } catch (e) {
      if (mounted) {
        _showWarning('Erro ao cadastrar: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showWarning(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline_rounded, color: Colors.white),
            const SizedBox(width: 10.0),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: FlutterFlowTheme.of(context).error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        FlutterFlowIconButton(
                          borderColor: theme.alternate,
                          borderRadius: 24.0,
                          borderWidth: 1.0,
                          buttonSize: 44.0,
                          fillColor: theme.secondaryBackground,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: theme.primaryText,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            context.goNamed(InicioWidget.routeName);
                          },
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: theme.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: theme.primary.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded, size: 14.0, color: theme.primary),
                              const SizedBox(width: 6.0),
                              Text(
                                'NOVO CLIENTE',
                                style: GoogleFonts.inter(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700,
                                  color: theme.primary,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    // Header Emblem
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.primary,
                            const Color(0xFF9A6B1F),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.primary.withOpacity(0.35),
                            blurRadius: 16.0,
                            offset: const Offset(0.0, 6.0),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person_add_alt_1_rounded,
                          color: Colors.black87,
                          size: 38.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),

                    Text(
                      'CRIAR CONTA DELACRUZ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: theme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Cadastre-se para agendamentos rápidos e benefícios exclusivos',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14.0,
                        color: theme.secondaryText,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28.0),

                    // Register Form Card
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: theme.alternate, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20.0,
                            offset: const Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name Field
                          Text(
                            'NOME COMPLETO',
                            style: GoogleFonts.inter(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              color: theme.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _model.nomeTextController,
                            focusNode: _model.nomeFocusNode,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            style: theme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'Ex: Leonardo Silva',
                              hintStyle: TextStyle(color: theme.secondaryText.withOpacity(0.6)),
                              prefixIcon: Icon(Icons.person_outline_rounded, color: theme.primary, size: 20.0),
                              filled: true,
                              fillColor: theme.primaryBackground,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.alternate),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.primary, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),

                          // Email Field
                          Text(
                            'E-MAIL',
                            style: GoogleFonts.inter(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              color: theme.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _model.eMailTextController,
                            focusNode: _model.eMailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: theme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'seu.email@exemplo.com',
                              hintStyle: TextStyle(color: theme.secondaryText.withOpacity(0.6)),
                              prefixIcon: Icon(Icons.mail_outline_rounded, color: theme.primary, size: 20.0),
                              filled: true,
                              fillColor: theme.primaryBackground,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.alternate),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.primary, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),

                          // Password Field
                          Text(
                            'SENHA (MÍNIMO 6 CARACTERES)',
                            style: GoogleFonts.inter(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              color: theme.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _model.senhaTextController,
                            focusNode: _model.senhaFocusNode,
                            obscureText: !_model.senhaVisibility,
                            textInputAction: TextInputAction.next,
                            style: theme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'Crie sua senha',
                              hintStyle: TextStyle(color: theme.secondaryText.withOpacity(0.6)),
                              prefixIcon: Icon(Icons.lock_outline_rounded, color: theme.primary, size: 20.0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _model.senhaVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: theme.secondaryText,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _model.senhaVisibility = !_model.senhaVisibility;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: theme.primaryBackground,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.alternate),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.primary, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),

                          // Repeat Password Field
                          Text(
                            'CONFIRMAR SENHA',
                            style: GoogleFonts.inter(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              color: theme.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _model.senhaRTextController,
                            focusNode: _model.senhaRFocusNode,
                            obscureText: !_model.senhaRVisibility,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _handleRegister(),
                            style: theme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'Repita sua senha',
                              hintStyle: TextStyle(color: theme.secondaryText.withOpacity(0.6)),
                              prefixIcon: Icon(Icons.lock_reset_rounded, color: theme.primary, size: 20.0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _model.senhaRVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: theme.secondaryText,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _model.senhaRVisibility = !_model.senhaRVisibility;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: theme.primaryBackground,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.alternate),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: theme.primary, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),

                          // Submit Button
                          SizedBox(
                            height: 52.0,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primary,
                                foregroundColor: Colors.black,
                                elevation: 4.0,
                                shadowColor: theme.primary.withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22.0,
                                      height: 22.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'FINALIZAR CADASTRO',
                                          style: GoogleFonts.interTight(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        const Icon(Icons.check_rounded, size: 20.0, color: Colors.black),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(height: 12.0),

                          // Clear button
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _model.nomeTextController?.clear();
                                _model.eMailTextController?.clear();
                                _model.senhaTextController?.clear();
                                _model.senhaRTextController?.clear();
                              });
                            },
                            icon: Icon(Icons.clear_all_rounded, size: 16.0, color: theme.secondaryText),
                            label: Text(
                              'Limpar campos',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                color: theme.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Already have an account link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Já tem uma conta? ',
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            color: theme.secondaryText,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(HomePageCopyWidget.routeName);
                          },
                          child: Text(
                            'Faça Login',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: theme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
