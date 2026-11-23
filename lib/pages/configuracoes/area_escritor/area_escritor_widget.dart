import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/pages/configuracoes/area_escritor/escrever_livro.dart/escrever_livro.dart';
import 'package:leitor_ebooks/pages/configuracoes/area_escritor/mocks.dart';
import 'package:provider/provider.dart';

class AreaEscritorWidget {
  BuildContext context;
  ScrollController _templateController;
  AreaEscritorWidget(this.context, this._templateController);

  Widget areaEscritoWidgetPrincipal(BuildContext contextAux) {
    final celular = getNumeroDeLinhas(context);
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: celular > 3
          ? EdgeInsets.symmetric(horizontal: size.width * 0.15)
          : EdgeInsets.symmetric(horizontal: size.width * 0.05),
      children: [
        _buildBackButton(context),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize * 1.5),

        // Estatísticas do Draft
        Text('Estatísticas do Draft',
            style: GlobalsStyles(context).styleSubtitle),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize),
        _statsSection(),

        // Quick Actions
        SizedBox(height: GlobalsSizes(context).marginSpaceSize * 1.5),
        _quickActionsSection(celular),

        // Meus Rascunhos
        SizedBox(height: GlobalsSizes(context).marginSpaceSize * 1.5),
        _draftsSection(celular),

        // Templates & Modelos
        SizedBox(height: GlobalsSizes(context).marginSpaceSize * 1.5),
        _templatesSection(celular),

        // Biblioteca de Assets
        SizedBox(height: GlobalsSizes(context).marginSpaceSize * 1.5),
        _assetsSection(),

        // Configurações de Estilo
        SizedBox(height: GlobalsSizes(context).marginSpaceSize * 1.5),
        _styleConfigsSection(),

        // Histórico de Sessões
        SizedBox(height: GlobalsSizes(context).marginSpaceSize * 1.5),
        _sessionsSection(),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios,
                color: globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
                size: GlobalsSizes(context).sizeTextMedio),
          ),
        )
      ]),
    );
  }

  Widget _statsSection() {
    return Row(children: [
      _statCard('Palavras', Mocks.stats.totalWords.toString()),
      _statCard('Hoje', Mocks.stats.chaptersCreatedToday.toString()),
      _statCard('Tempo',
          '${Mocks.stats.writingTime.inHours}h ${Mocks.stats.writingTime.inMinutes % 60}m'),
    ]);
  }

  Widget _quickActionsSection(int celular) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookEditorPage()),
              );
            },
            icon: Icon(Icons.add,
                color: globalsThemeVar.iGlobalsColors.textColorPrimaryInverse),
            label: Text('Novo Livro', style: GlobalsStyles(context).styleMedio),
            style: ElevatedButton.styleFrom(
                backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.upload,
                color: globalsThemeVar.iGlobalsColors.textColorPrimaryInverse),
            label: Text('Importar', style: GlobalsStyles(context).styleMedio),
            style: ElevatedButton.styleFrom(
                backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor),
          ),
          const SizedBox(width: 10),
          if (celular > 3)
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.create_new_folder,
                  color:
                      globalsThemeVar.iGlobalsColors.textColorPrimaryInverse),
              label: Text('Capítulo Avulso',
                  style: GlobalsStyles(context).styleMedio),
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      globalsThemeVar.iGlobalsColors.tertiaryColor),
            ),
        ]),
        if (celular <= 3)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalsSizes(context).marginSpaceSize * 1.5),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.create_new_folder,
                  color:
                      globalsThemeVar.iGlobalsColors.textColorPrimaryInverse),
              label: Text('Capítulo Avulso',
                  style: GlobalsStyles(context).styleMedio),
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      globalsThemeVar.iGlobalsColors.tertiaryColor),
            ),
          ),
      ],
    );
  }

  Widget _draftsSection(int celular) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Meus Rascunhos em Andamento',
          style: GlobalsStyles(context).styleSubtitle),
      SizedBox(height: GlobalsSizes(context).marginSpaceSize),
      SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Mocks.drafts.length,
          itemBuilder: (_, i) {
            final d = Mocks.drafts[i];
            return _draftCard(d, celular);
          },
        ),
      ),
    ]);
  }

  Widget _draftCard(d, int celular) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Card(
      color: globalsThemeVar.iGlobalsColors.tertiaryColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(GlobalsSizes(context).borderSize)),
      elevation: 2.0,
      child: SizedBox(
        width: celular > 3 ? 200 : 160,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(GlobalsSizes(context).borderSize),
                topRight: Radius.circular(GlobalsSizes(context).borderSize),
              ),
              child: CachedNetworkImage(
                imageUrl: d.coverUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorWidget: (context, url, error) =>
                    GlobalsWidgets(context).loading(size: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(d.title,
                  style: GlobalsStyles(context).styleMedio,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              Text('${d.completedChapters}/${d.totalChapters} capítulos',
                  style: GlobalsStyles(context).styleMenor,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _templatesSection(int celular) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Templates & Modelos', style: GlobalsStyles(context).styleSubtitle),
      SizedBox(height: GlobalsSizes(context).marginSpaceSize),
      SizedBox(
        height: 80,
        child: Row(children: [
          if (celular > 3)
            IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color:
                      globalsThemeVar.iGlobalsColors.textColorPrimaryInverse),
              onPressed: () {
                final offset = (_templateController.offset - 120)
                    .clamp(0.0, _templateController.position.maxScrollExtent);
                _templateController.animateTo(offset,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
            ),
          Expanded(
            child: ListView.builder(
              controller: _templateController,
              scrollDirection: Axis.horizontal,
              itemCount: Mocks.templates.length,
              itemBuilder: (_, i) {
                final t = Mocks.templates[i];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 12),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(t.icon,
                            color: globalsThemeVar
                                .iGlobalsColors.textColorPrimaryInverse),
                        SizedBox(height: 4),
                        Text(t.name,
                            textAlign: TextAlign.center,
                            style: GlobalsStyles(context).styleMenor),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (celular > 3)
            IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  color:
                      globalsThemeVar.iGlobalsColors.textColorPrimaryInverse),
              onPressed: () {
                final offset = (_templateController.offset + 120)
                    .clamp(0.0, _templateController.position.maxScrollExtent);
                _templateController.animateTo(offset,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
            ),
        ]),
      ),
    ]);
  }

  Widget _assetsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Biblioteca de Assets', style: GlobalsStyles(context).styleSubtitle),
      SizedBox(height: GlobalsSizes(context).marginSpaceSize),
      SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Mocks.assets.length,
          itemBuilder: (_, i) {
            final a = Mocks.assets[i];
            return Container(
              width: 150,
              margin: EdgeInsets.only(right: 12),
              child: OutlinedButton(
                onPressed: () {},
                child: Column(children: [
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: CachedNetworkImage(
                      imageUrl: a.thumbUrl,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorWidget: (c, u, e) =>
                          GlobalsWidgets(context).loading(size: 25),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(a.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalsStyles(context).styleMenor),
                ]),
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget _styleConfigsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Configurações de Estilo',
          style: GlobalsStyles(context).styleSubtitle),
      SizedBox(height: GlobalsSizes(context).marginSpaceSize),
      SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Mocks.styleConfigs.length,
          itemBuilder: (_, i) {
            final s = Mocks.styleConfigs[i];
            return Padding(
              padding: EdgeInsets.only(right: 12),
              child: Column(children: [
                Icon(s.icon,
                    color: Provider.of<GlobalsThemeVar>(context, listen: false)
                        .iGlobalsColors
                        .textColorPrimaryInverse),
                SizedBox(height: 4),
                Text(s.label, style: GlobalsStyles(context).styleMenor),
              ]),
            );
          },
        ),
      ),
    ]);
  }

  Widget _sessionsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Histórico de Sessões', style: GlobalsStyles(context).styleSubtitle),
      SizedBox(height: GlobalsSizes(context).marginSpaceSize),
      ...Mocks.sessions.map((sess) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.history,
              color: Provider.of<GlobalsThemeVar>(context, listen: false)
                  .iGlobalsColors
                  .textColorPrimaryInverse),
          title: Text('${sess.wordsWritten} palavras',
              style: GlobalsStyles(context).styleMenor),
          subtitle: Text('${sess.date.toLocal()}'.split(' ')[0],
              style: GlobalsStyles(context).styleMenor),
        );
      }).toList(),
    ]);
  }

  Widget _statCard(String label, String value) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Expanded(
      child: Card(
        color: globalsThemeVar.iGlobalsColors.tertiaryColor,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            Text(value, style: GlobalsStyles(context).styleMedio),
            Text(label, style: GlobalsStyles(context).styleMenor),
          ]),
        ),
      ),
    );
  }
}
