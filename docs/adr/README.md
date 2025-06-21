# Architectural Decision Log

This log lists the architectural decisions for this project.

<!-- toc -->

* [ADR-0000](0000-use-markdown-architectural-decision-records.md) - Use Markdown Architectural Decision Records - [accepted]
* [ADR-0001](0001-base-dio-wrapper-http-client.md) - BaseDioWrapperを使用したHTTPクライアント実装 - [superseded]
* [ADR-0002](0002-environment-configuration-management.md) - 環境設定の型安全な管理とマルチポータル対応 - [accepted, updated]
* [ADR-0003](0003-secure-credential-storage-implementation.md) - セキュアクレデンシャルストレージの実装と管理戦略 - [accepted]
* [ADR-0004](0004-remove-tls-certificate-pinning.md) - TLS証明書ピニングの廃止 - [accepted]

<!-- tocstop -->

---

For new ADRs, please use [template.md](template.md) as basis. You can easily create a new ADR with [adr-tool](https://www.npmjs.com/package/adr-tool) based on the template:

```bash
npx adr-tool create <decision>
```

---

More information on MADR is available at <https://adr.github.io/madr/>.
General information about architectural decision records is available at <https://adr.github.io/>.
