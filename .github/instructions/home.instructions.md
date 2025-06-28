---
applyTo: "lib/features/home/**"
---

# Home Feature – Implementation Rules

> **Goal**: Build the “Home” tab that surfaces fresh information students care about at-a-glance.
> **Data sources**:
> • MaNaBo System News • MaNaBo Received Mail • MaNaBo Mail Content View • ALBO News.

---

## 1  Folder Skeleton

```
lib/features/home/
 ├─ data/
 │   ├─ datasources/
 │   │   ├─ manabo_system_news_remote_ds.dart
 │   │   ├─ manabo_received_mail_remote_ds.dart
 │   │   ├─ manabo_mail_view_remote_ds.dart
 │   │   └─ albo_news_remote_ds.dart
 │   ├─ parsers/                # html↔DTO converters
 │   │   ├─ manabo_news_parser.dart
 │   │   └─ albo_news_parser.dart
 │   ├─ models/                 # DTOs (Freezed + json)
 │   └─ repositories/           # impls; depend on core/network
 ├─ domain/
 │   ├─ entities/               # NewsItem, MailSummary, MailBody …
 │   ├─ value_objects/
 │   └─ use_cases/
 ├─ application/
 │   ├─ home_notifier.dart      # main AsyncNotifier
 │   ├─ mail_view_notifier.dart # handles currently-opened mail
 │   └─ providers.dart          # all Riverpod exposes
 └─ presentation/
     ├─ pages/
     │   └─ home_page.dart
     ├─ widgets/
     │   ├─ news_section.dart
     │   ├─ mail_section.dart
     │   └─ albo_section.dart
     └─ navigation.dart          # pushMailView(context, mailId)
```

> **Tests**
> • `domain/` → pure logic TDD
> • `application/` → notifier state & edge-cases
> • `presentation/` → golden & behavior

---

## 2  Endpoints & Datasource Specs

| Data              | URL                                                                            | Method | Payload                                   | Notes                                      |
| ----------------- | ------------------------------------------------------------------------------ | ------ | ----------------------------------------- | ------------------------------------------ |
| **System News**   | `https://manabo.cnc.chukyo-u.ac.jp/`                                           | POST   | `action=glexa_ajax_news_list`             | HTML table; use `manabo_news_parser.dart`. |
| **Received Mail** | same                                                                           | POST   | `p=2&action=glexa_ajax_mail_receive_list` | Also HTML list.                            |
| **Mail Content**  | `https://manabo.cnc.chukyo-u.ac.jp/?mail_id={id}&action=glexa_modal_mail_view` | GET    | —                                         | Returns full modal HTML.                   |
| **ALBO News**     | `https://cubics-pt-out.mng.chukyo-u.ac.jp/uniprove_pt/portal/_ns:YXJ...`       | GET    | —                                         | UTF-8 HTML.                                |

* Wrap calls in **Dio** instances fetched via
  `ref.read(networkClientProvider(NetworkTarget.manabo))` etc.
* **Timeout**: 15 s; **retry**: handled by core interceptor.
* Treat HTTP 503 as *maintenance*—surface `MaintenanceGuard`.

---

## 3  Caching & Background Refresh

| Resource         | TTL              | BG task ID          |
| ---------------- | ---------------- | ------------------- |
| System News      | 5 min            | `home.news.refresh` |
| Received Mail    | 2 min            | `home.mail.refresh` |
| Mail Body (view) | 0 min (no cache) | —                   |
| ALBO News        | 10 min           | `home.albo.refresh` |

* Use *stale-while-revalidate*: serve cache instantly, then fire network.
* Register tasks via `backgroundSchedulerProvider.registerUnique()`; require network.
* Persist cache in `keyValueCacheProvider` under `cache.home.*`.

---

## 4  Domain Layer

```dart
@freezed
class NewsItem with _$NewsItem {
  const factory NewsItem({
    required String id,
    required String title,
    required DateTime publishedAt,
    required String bodyHtml,   // full text, sanitized later
    required Uri detailUrl,
  }) = _NewsItem;
}

@freezed
class MailSummary with _$MailSummary { … }

@freezed
class MailBody with _$MailBody { … }
```

* Create use-cases:

  * `GetLatestSystemNewsUseCase`
  * `GetLatestAlboNewsUseCase`
  * `GetReceivedMailUseCase`
  * `GetMailBodyUseCase`

Return **`Result<E, AppException>`** or throw `AppException`.

---

## 5  Application Layer

```dart
class HomeState {
  final AsyncValue<List<NewsItem>> systemNews;
  final AsyncValue<List<AlboNewsItem>> alboNews;
  final AsyncValue<List<MailSummary>> receivedMail;
}

class HomeNotifier extends AsyncNotifier<HomeState> { … }
```

* Expose providers:

```dart
final homeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<HomeNotifier, HomeState>(() => …);

final mailBodyProvider = FutureProvider.autoDispose
    .family<MailBody, String>((ref, mailId) async { … });
```

* **Error mapping**: propagate untouched—UI will display `ErrorOverlay`.

---

## 6  UI Guidelines (presentation/)

* `HomePage` = scrollable column containing:

  1. **System News** – horizontal `ListView` of cards (max 10).
  2. **ALBO News** – same style, smaller badge “ALBO”.
  3. **Received Mail** – collapsible section; tap row → `MailViewSheet`.
* Use shimmer placeholders while loading.
* Pull-to-refresh triggers `homeNotifier.refresh()`.

---

## 7  Fail-safe & Edge-cases

1. No network → show cached data + “Offline” banner.
2. Cache empty & fetch fails → show `EmptySection` with retry.
3. HTML parser throws → log via Crashlytics; show raw string fallback.

---

## 8  Unit & Widget Tests

```
data/   → parse HTML sample → DTO list length > 0
domain/ → GetLatestSystemNewsUseCase returns <= 10 sorted desc
app/    → HomeNotifier emits loading→data, handles error
ui/     → Golden of HomePage (dark/light), MailViewSheet
```

---

## 9  Ready-to-code Checklist

* [ ] Create folder skeleton above.
* [ ] Implement parsers with `html` (package).
* [ ] Wire repositories + use-cases.
* [ ] Write notifier & UI widgets.
* [ ] Add background tasks & TTL constants.

---
