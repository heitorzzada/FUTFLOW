import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AtividadeRecord extends FirestoreRecord {
  AtividadeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "titulo" field.
  String? _titulo;
  String get titulo => _titulo ?? '';
  bool hasTitulo() => _titulo != null;

  // "descricao" field.
  String? _descricao;
  String get descricao => _descricao ?? '';
  bool hasDescricao() => _descricao != null;

  // "criado_em" field.
  DateTime? _criadoEm;
  DateTime? get criadoEm => _criadoEm;
  bool hasCriadoEm() => _criadoEm != null;

  void _initializeFields() {
    _titulo = snapshotData['titulo'] as String?;
    _descricao = snapshotData['descricao'] as String?;
    _criadoEm = snapshotData['criado_em'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('atividade');

  static Stream<AtividadeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AtividadeRecord.fromSnapshot(s));

  static Future<AtividadeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AtividadeRecord.fromSnapshot(s));

  static AtividadeRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AtividadeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AtividadeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AtividadeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AtividadeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AtividadeRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createAtividadeRecordData({
  String? titulo,
  String? descricao,
  DateTime? criadoEm,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'titulo': titulo,
      'descricao': descricao,
      'criado_em': criadoEm,
    }.withoutNulls,
  );

  return firestoreData;
}

class AtividadeRecordDocumentEquality implements Equality<AtividadeRecord> {
  const AtividadeRecordDocumentEquality();

  @override
  bool equals(AtividadeRecord? e1, AtividadeRecord? e2) {
    return e1?.titulo == e2?.titulo &&
        e1?.descricao == e2?.descricao &&
        e1?.criadoEm == e2?.criadoEm;
  }

  @override
  int hash(AtividadeRecord? e) =>
      const ListEquality().hash([e?.titulo, e?.descricao, e?.criadoEm]);

  @override
  bool isValidKey(Object? o) => o is AtividadeRecord;
}
