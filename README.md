# Biblioteca Élfica

App de leitura e publicação de livros feito em **Flutter**, com uma API própria em Node.js ([biblioteca-elfica-api](https://github.com/Haimcer/biblioteca-elfica-api)).

Leitores encontram livros por categoria, curtem, comentam, seguem escritores e montam a própria biblioteca. Escritores têm uma área para cadastrar o perfil, criar e editar livros com editor de texto rico e acompanhar tudo num painel.

## Funcionalidades

- Login com e-mail/senha e Google (Firebase Authentication)
- Catálogo por categorias, detalhes do livro, favoritos e biblioteca pessoal
- Curtidas, comentários e seguidores
- Área do escritor: cadastro, criação e edição de livros com editor rico (Flutter Quill)
- Leitura de ePub (Vocsy Epub Viewer)
- Upload de capas e arquivos (via API, com AWS S3)
- Renovação automática do token quando expira
- Funciona em Android, iOS e Web

## Stack

Flutter · Dart · MobX · Provider · Dio/HTTP · Firebase Auth · Google Sign-In · Flutter Quill · Rive

## Como rodar

1. Clone o repositório e instale as dependências:
   ```bash
   flutter pub get
   ```
2. Copie `dart_defines.example.json` para `dart_defines.json` e preencha com os dados do seu projeto Firebase e a URL da API.
3. Para Android/iOS, coloque o seu `google-services.json` / `GoogleService-Info.plist` (eles não ficam no repositório).
4. Rode:
   ```bash
   flutter run --dart-define-from-file=dart_defines.json
   ```

## Estrutura

```txt
lib/
 ├─ controllers/   estado global (MobX)
 ├─ globals/       widgets e variáveis compartilhadas
 ├─ modals/        modelos de dados
 ├─ pages/         telas (home, login, detalhes, favoritos, dashboard, configurações)
 └─ request/       chamadas à API
```

---

Desenvolvido por [Allan Ribeiro](https://github.com/Haimcer) · [LinkedIn](https://www.linkedin.com/in/allan-ribeiro-silva-46596134a/)
