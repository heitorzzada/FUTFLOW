import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'atividade_create_model.dart';
export 'atividade_create_model.dart';

class AtividadeCreateWidget extends StatefulWidget {
  const AtividadeCreateWidget({super.key});

  static String routeName = 'AtividadeCreate';
  static String routePath = '/atividadeCreate';

  @override
  State<AtividadeCreateWidget> createState() => _AtividadeCreateWidgetState();
}

class _AtividadeCreateWidgetState extends State<AtividadeCreateWidget> {
  late AtividadeCreateModel _model;
  bool _isSaving = false;
  String _selectedCategory = 'Cabelo';
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _duracaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _categories = [
    'Cabelo',
    'Barba',
    'Combos',
    'Tratamentos',
    'Outros',
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AtividadeCreateModel());

    _model.infTextController ??= TextEditingController();
    _model.infFocusNode ??= FocusNode();

    _model.descricaoTextController ??= TextEditingController();
    _model.descricaoFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    _precoController.dispose();
    _duracaoController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveService() async {
    final title = _model.infTextController?.text.trim() ?? '';
    final description = _model.descricaoTextController?.text.trim() ?? '';
    final price = _precoController.text.trim();
    final duration = _duracaoController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Por favor, informe o título do serviço.'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final fullDesc = [
        if (description.isNotEmpty) description,
        'Categoria: $_selectedCategory',
        if (price.isNotEmpty) 'Valor: R\$ $price',
        if (duration.isNotEmpty) 'Duração: $duration min',
      ].join(' | ');

      await AtividadeRecord.collection.add(createAtividadeRecordData(
        titulo: title,
        descricao: fullDesc,
        criadoEm: DateTime.now(),
      ));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 8.0),
              Text('Serviço cadastrado com sucesso na Delacruz!'),
            ],
          ),
          backgroundColor: FlutterFlowTheme.of(context).success,
          behavior: SnackBarBehavior.floating,
        ),
      );

      _model.infTextController?.clear();
      _model.descricaoTextController?.clear();
      _precoController.clear();
      _duracaoController.clear();

      context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar serviço: ${e.toString()}'),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
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
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
          elevation: 0.0,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 50.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: theme.primaryText,
              size: 22.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Novo Serviço / Atividade',
            style: GoogleFonts.cinzel(
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
              color: theme.primaryText,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: theme.alternate, height: 1.0),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Card
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: theme.alternate),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: theme.primary.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add_business_rounded, color: theme.primary, size: 26.0),
                        ),
                        const SizedBox(width: 14.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Catálogo Barbearia Delacruz',
                                style: GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.bold, color: theme.primaryText),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'Adicione novos serviços, combos ou tratamentos ao sistema',
                                style: GoogleFonts.inter(fontSize: 12.0, color: theme.secondaryText),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Categoria
                  Text(
                    'CATEGORIA DO SERVIÇO',
                    style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w700, color: theme.secondaryText, letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _selectedCategory = cat),
                        selectedColor: theme.primary,
                        backgroundColor: theme.secondaryBackground,
                        labelStyle: GoogleFonts.inter(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.black : theme.primaryText,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: isSelected ? theme.primary : theme.alternate),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20.0),

                  // Title Field
                  Text(
                    'TÍTULO DO SERVIÇO *',
                    style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w700, color: theme.secondaryText, letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _model.infTextController,
                    focusNode: _model.infFocusNode,
                    style: theme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Ex: Corte Degradê Navalhado',
                      prefixIcon: Icon(Icons.content_cut, color: theme.primary, size: 20.0),
                      filled: true,
                      fillColor: theme.secondaryBackground,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Row: Price & Duration
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r'VALOR (R$)',
                              style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w700, color: theme.secondaryText, letterSpacing: 1.0),
                            ),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: _precoController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: theme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: '45.00',
                                prefixIcon: Icon(Icons.attach_money, color: theme.primary, size: 20.0),
                                filled: true,
                                fillColor: theme.secondaryBackground,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DURAÇÃO (MIN)',
                              style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w700, color: theme.secondaryText, letterSpacing: 1.0),
                            ),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: _duracaoController,
                              keyboardType: TextInputType.number,
                              style: theme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: '40',
                                prefixIcon: Icon(Icons.timer_outlined, color: theme.primary, size: 20.0),
                                filled: true,
                                fillColor: theme.secondaryBackground,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Description Field
                  Text(
                    'DESCRIÇÃO DETALHADA',
                    style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w700, color: theme.secondaryText, letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _model.descricaoTextController,
                    focusNode: _model.descricaoFocusNode,
                    maxLines: 4,
                    style: theme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Descreva os detalhes, técnicas utilizadas e benefícios...',
                      filled: true,
                      fillColor: theme.secondaryBackground,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                  const SizedBox(height: 28.0),

                  // Submit Button
                  SizedBox(
                    height: 52.0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                        elevation: 3.0,
                      ),
                      onPressed: _isSaving ? null : _handleSaveService,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.black),
                            )
                          : const Icon(Icons.save_rounded, color: Colors.black),
                      label: Text(
                        _isSaving ? 'SALVANDO...' : 'CADASTRAR SERVIÇO',
                        style: GoogleFonts.interTight(fontSize: 14.0, fontWeight: FontWeight.w800, letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
