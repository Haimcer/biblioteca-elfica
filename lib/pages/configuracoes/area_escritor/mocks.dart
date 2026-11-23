import 'package:flutter/material.dart';

/// Modelos de dados usados pelos mocks
class BookDraft {
  final String title;
  final String coverUrl;
  final int totalChapters;
  final int completedChapters;

  BookDraft({
    required this.title,
    required this.coverUrl,
    required this.totalChapters,
    required this.completedChapters,
  });
}

class TemplateModel {
  final String name;
  final IconData icon;

  TemplateModel({required this.name, required this.icon});
}

class AssetModel {
  final String name;
  final String thumbUrl;

  AssetModel({required this.name, required this.thumbUrl});
}

class StyleConfig {
  final String label;
  final IconData icon;

  StyleConfig({required this.label, required this.icon});
}

class SessionHistory {
  final DateTime date;
  final int wordsWritten;

  SessionHistory({required this.date, required this.wordsWritten});
}

class DraftStats {
  final int totalWords;
  final int chaptersCreatedToday;
  final Duration writingTime;

  DraftStats({
    required this.totalWords,
    required this.chaptersCreatedToday,
    required this.writingTime,
  });
}

// Dados de exemplo (mocks)
final List<BookDraft> _drafts = [
  BookDraft(
    title: 'A Jornada do Herói',
    coverUrl: 'https://picsum.photos/seed/book1/100/150',
    totalChapters: 12,
    completedChapters: 4,
  ),
  BookDraft(
    title: 'Encantos da Lua',
    coverUrl: 'https://picsum.photos/seed/book2/100/150',
    totalChapters: 8,
    completedChapters: 2,
  ),
];

final List<TemplateModel> _templates = [
  TemplateModel(name: 'Romance Padrão', icon: Icons.book),
  TemplateModel(name: 'Guia Técnico', icon: Icons.code),
  TemplateModel(name: 'Contos e Poemas', icon: Icons.brush),
  TemplateModel(name: 'Fantasia Épica', icon: Icons.auto_stories),
  TemplateModel(name: 'Mistério e Suspense', icon: Icons.visibility),
  TemplateModel(name: 'Ficção Científica', icon: Icons.science),
  TemplateModel(name: 'Biografia', icon: Icons.person),
  TemplateModel(name: 'Autoajuda', icon: Icons.self_improvement),
  TemplateModel(name: 'Desenvolvimento Pessoal', icon: Icons.trending_up),
  TemplateModel(name: 'Poesia Livre', icon: Icons.format_quote),
  TemplateModel(name: 'Infantojuvenil', icon: Icons.child_friendly),
  TemplateModel(name: 'Histórico', icon: Icons.history_edu),
  TemplateModel(name: 'Drama', icon: Icons.theater_comedy),
  TemplateModel(name: 'Thriller Psicológico', icon: Icons.psychology),
  TemplateModel(name: 'Romance Histórico', icon: Icons.account_balance),
  TemplateModel(name: 'Terror', icon: Icons.nights_stay),
  TemplateModel(name: 'Humor', icon: Icons.emoji_emotions),
  TemplateModel(name: 'Aventura', icon: Icons.explore),
  TemplateModel(name: 'Distopia', icon: Icons.public),
  TemplateModel(name: 'Cyberpunk', icon: Icons.electrical_services),
  TemplateModel(name: 'Realismo Mágico', icon: Icons.auto_awesome),
  TemplateModel(name: 'Memórias', icon: Icons.bookmark),
  TemplateModel(name: 'Crônicas Urbanas', icon: Icons.location_city),
  TemplateModel(name: 'Jovem Adulto', icon: Icons.people),
];

final List<AssetModel> _assets = [
  AssetModel(name: 'Separador Floral', thumbUrl: 'https://picsum.photos/seed/asset1/80/80'),
  AssetModel(name: 'Cabeçalho Vintage', thumbUrl: 'https://picsum.photos/seed/asset2/80/80'),
  AssetModel(name: 'Textura Papel', thumbUrl: 'https://picsum.photos/seed/asset3/80/80'),
];

final List<StyleConfig> _styleConfigs = [
  StyleConfig(label: 'Papel Liso', icon: Icons.description),
  StyleConfig(label: 'Pautado', icon: Icons.view_stream),
  StyleConfig(label: 'Pontilhado', icon: Icons.drag_handle),
  StyleConfig(label: 'Grade 5 mm', icon: Icons.grid_on),
  StyleConfig(label: 'Grade 10 mm', icon: Icons.grid_view),
  StyleConfig(label: 'Margem Vermelha', icon: Icons.border_left),
  StyleConfig(label: 'Folha Amarelada', icon: Icons.filter_vintage),
  StyleConfig(label: 'Carta (A4)', icon: Icons.picture_as_pdf),
  StyleConfig(label: 'Bullet Journal', icon: Icons.circle_notifications),
  StyleConfig(label: 'Manilha', icon: Icons.sticky_note_2),
  StyleConfig(label: 'Minimalista', icon: Icons.crop_square),
];

final List<SessionHistory> _sessions = [
  SessionHistory(date: DateTime.now().subtract(Duration(days: 1)), wordsWritten: 1200),
  SessionHistory(date: DateTime.now().subtract(Duration(days: 2)), wordsWritten: 800),
];

final DraftStats _stats = DraftStats(
  totalWords: 15000,
  chaptersCreatedToday: 1,
  writingTime: Duration(hours: 2, minutes: 30),
);

/// Classe única para acesso fácil aos mocks
class Mocks {
  /// Lista de rascunhos de livros
  static List<BookDraft> get drafts => _drafts;

  /// Modelos de template disponíveis
  static List<TemplateModel> get templates => _templates;

  /// Assets de interface mockados
  static List<AssetModel> get assets => _assets;

  /// Configurações de estilo mockadas
  static List<StyleConfig> get styleConfigs => _styleConfigs;

  /// Histórico de sessões de escrita
  static List<SessionHistory> get sessions => _sessions;

  /// Estatísticas gerais de escrita
  static DraftStats get stats => _stats;
}

