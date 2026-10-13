import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page_copy_model.dart';
export 'home_page_copy_model.dart';

class HomePageCopyWidget extends StatefulWidget {
  const HomePageCopyWidget({super.key});

  static String routeName = 'HomePageCopy';
  static String routePath = '/homePageCopy';

  @override
  State<HomePageCopyWidget> createState() => _HomePageCopyWidgetState();
}

class _HomePageCopyWidgetState extends State<HomePageCopyWidget> {
  late HomePageCopyModel _model;
  bool _isLoading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageCopyModel());

    _model.eMailTextController ??= TextEditingController();
    _model.eMailFocusNode ??= FocusNode();

    _model.senhaTextController ??= TextEditingController();
    _model.senhaFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _model.eMailTextController?.text.trim() ?? '';
    final password = _model.senhaTextController?.text.trim() ?? '';

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 10.0),
              Expanded(child: Text('Por favor, preencha o e-mail e a senha.')),
            ],
          ),
          backgroundColor: FlutterFlowTheme.of(context).error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      GoRouter.of(context).prepareAuthEvent();
      final user = await authManager.signInWithEmail(
        context,
        email,
        password,
      );

      if (!mounted) return;

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 10.0),
                Text('Bem-vindo de volta à Barbearia Delacruz!'),
              ],
            ),
            backgroundColor: FlutterFlowTheme.of(context).success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.goNamedAuth(InicioWidget.routeName, context.mounted);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.error_outline_rounded, color: Colors.white),
                SizedBox(width: 10.0),
                Expanded(child: Text('E-mail ou senha incorretos. Verifique suas credenciais.')),
              ],
            ),
            backgroundColor: FlutterFlowTheme.of(context).error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao realizar login: ${e.toString()}'),
            backgroundColor: FlutterFlowTheme.of(context).error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleForgotPassword() async {
    final email = _model.eMailTextController?.text.trim() ?? '';
    final emailController = TextEditingController(text: email);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          title: Row(
            children: [
              Icon(Icons.lock_reset, color: FlutterFlowTheme.of(context).primary),
              const SizedBox(width: 8.0),
              Text(
                'Redefinir Senha',
                style: FlutterFlowTheme.of(context).titleMedium,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Digite seu e-mail cadastrado para receber o link de recuperação de senha:',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Seu E-mail',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancelar', style: TextStyle(color: FlutterFlowTheme.of(context).secondaryText)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () async {
                final targetEmail = emailController.text.trim();
                if (targetEmail.isEmpty) return;
                Navigator.pop(dialogContext);
                await authManager.resetPassword(email: targetEmail, context: context);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Instruções enviadas para $targetEmail'),
                      backgroundColor: FlutterFlowTheme.of(context).info,
                    ),
                  );
                }
              },
              child: const Text('Enviar Link', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
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
                    // Top Bar with back button
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
                              Icon(Icons.content_cut_rounded, size: 14.0, color: theme.primary),
                              const SizedBox(width: 6.0),
                              Text(
                                'DELACRUZ VIP',
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
                    const SizedBox(height: 24.0),

                    // Logo Emblem
                    Container(
                      width: 88.0,
                      height: 88.0,
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
                            blurRadius: 18.0,
                            offset: const Offset(0.0, 8.0),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.content_cut_rounded,
                          color: Colors.black87,
                          size: 42.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Titles
                    Text(
                      'BARBEARIA DELACRUZ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                        color: theme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Entre na sua conta para agendar e gerenciar seus horários',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14.0,
                        color: theme.secondaryText,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32.0),

                    // Login Card Form
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
                              hintText: 'exemplo@email.com',
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
                          const SizedBox(height: 20.0),

                          // Password Field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SENHA',
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                  color: theme.secondaryText,
                                ),
                              ),
                              GestureDetector(
                                onTap: _handleForgotPassword,
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: theme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _model.senhaTextController,
                            focusNode: _model.senhaFocusNode,
                            obscureText: !_model.senhaVisibility,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _handleLogin(),
                            style: theme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'Digite sua senha',
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
                          const SizedBox(height: 24.0),

                          // Login Button
                          SizedBox(
                            height: 52.0,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
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
                                          'ENTRAR',
                                          style: GoogleFonts.interTight(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        const Icon(Icons.arrow_forward_rounded, size: 18.0, color: Colors.black),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Don't have account link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ainda não tem cadastro? ',
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            color: theme.secondaryText,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(HomePageWidget.routeName);
                          },
                          child: Text(
                            'Criar conta',
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
                    const SizedBox(height: 16.0),

                    // Guest explore button
                    OutlinedButton.icon(
                      onPressed: () {
                        context.goNamed(InicioWidget.routeName);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: theme.alternate),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      ),
                      icon: Icon(Icons.storefront_outlined, size: 18.0, color: theme.secondaryText),
                      label: Text(
                        'Explorar Serviços sem Login',
                        style: GoogleFonts.inter(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: theme.secondaryText,
                        ),
                      ),
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
