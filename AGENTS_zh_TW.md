# Kestra AGENTS.md

此檔案為在 Kestra 專案上工作的 AI 編碼代理（AI coding agents）提供指引。Kestra 是一個使用 Java (Micronaut) 和 Vue.js 構建的開源數據編排和調度平台。

## 儲存庫佈局

- **`core/`**：核心 Kestra 框架和任務定義
- **`cli/`**：命令列介面（CLI）和伺服器實作
- **`webserver/`**：REST API 伺服器實作
- **`ui/`**：Vue.js 前端應用程式
- **`jdbc-*`**：資料庫連接器模組（H2、MySQL、PostgreSQL）
- **`script/`**：腳本執行引擎
- **`storage-local/`**：本地檔案儲存實作
- **`repository-memory/`**：記憶體內儲存庫實作
- **`runner-memory/`**：記憶體內執行運行器（runner）
- **`processor/`**：任務處理引擎
- **`model/`**：資料模型和資料傳輸物件（DTO）
- **`platform/`**：平台相關實作
- **`tests/`**：整合測試框架

## 開發環境

### 前提條件

- Java 25+
- Node.js 22+ 和 npm
- Python 3, pip 和 python venv
- Docker & Docker Compose
- Gradle (包含 wrapper)

### 使用 Devcontainer 快速設置

最簡單的入門方法是使用提供的 devcontainer：

1. 安裝 VSCode Remote Development 擴充功能
2. 從命令面板執行 `Dev Containers: Open Folder in Container...`
3. 選擇 Kestra 根資料夾
4. 等待 Gradle 建置完成

### 手動設置

1. 複製儲存庫
2. 執行 `./gradlew build` 以建置後端
3. 導覽至 `ui/` 並執行 `npm install`
4. 按照下文所述建立配置檔案

## 配置檔案

### 後端配置

建立 `cli/src/main/resources/application-override.yml`：

**本地模式（H2 資料庫）：**

```yaml
micronaut:
  server:
    cors:
      enabled: true
      configurations:
        all:
          allowedOrigins:
            - http://localhost:5173
```

**獨立模式（PostgreSQL）：**

```yaml
kestra:
  repository:
    type: postgres
  storage:
    type: local
    local:
      base-path: "/app/storage"
  queue:
    type: postgres
  tasks:
    tmp-dir:
      path: /tmp/kestra-wd/tmp
  anonymous-usage-report:
    enabled: false

datasources:
  postgres:
    url: jdbc:postgresql://host.docker.internal:5432/kestra
    driverClassName: org.postgresql.Driver
    username: kestra
    password: k3str4

flyway:
  datasources:
    postgres:
      enabled: true
      locations:
        - classpath:migrations/postgres
      ignore-migration-patterns: "*:missing,*:future"
      out-of-order: true

micronaut:
  server:
    cors:
      enabled: true
      configurations:
        all:
          allowedOrigins:
            - http://localhost:5173
```

### 前端配置

建立 `ui/.env.development.local` 用於環境變數。

## 運行應用程式

### 後端

- **本地模式**：`./gradlew runLocal`（使用 H2 資料庫）
- **獨立模式**：使用 VSCode 的「執行和偵錯」，主類別為 `io.kestra.cli.App`，參數為 `server standalone`

### 前端

- 導覽至 `ui/` 目錄
- 執行 `npm run dev` 啟動開發伺服器（埠 5173）
- 執行 `npm run build` 進行生產環境建置

## 建置與測試

### 後端

```bash
# 建置專案
./gradlew build

# 執行測試
./gradlew test

# 執行特定模組測試
./gradlew :core:test

# 清理並建置
./gradlew clean build
```

### 前端

```bash
cd ui
npm install
npm run test
npm run lint
npm run build
```

### 端對端（E2E）測試

```bash
# 建置並啟動 E2E 測試
./build-and-start-e2e-tests.sh

# 或使用 Makefile
make install
make install-plugins
make start-standalone-postgres
```

## 開發指南

### Java 後端

- 使用 Java 25 特性
- 遵循 Micronaut 框架模式
- 為 API 文檔添加 Swagger 註解
- 使用註解處理器（在 IDE 中啟用）
- 為自定義配置設置 `MICRONAUT_ENVIRONMENTS=local,override`
- 為自定義插件加載設置 `KESTRA_PLUGINS_PATH`

### Vue.js 前端

- 帶有 Composition API 的 Vue 3
- 使用 TypeScript 確保類型安全
- 使用 Vite 作為建置工具
- 使用 ESLint 和 Prettier 確保代碼質量
- `src/components/` 中的組件化架構

### 代碼風格

- 遵循 `.editorconfig` 設置
- Java 使用 4 個空格，YAML/JSON/CSS 使用 2 個空格
- 在 VSCode 中啟用儲存時格式化
- 使用 Prettier 進行前端代碼格式化

## 測試策略

### 後端測試

- `src/test/java/` 中的單元測試
- `tests/` 模組中的整合測試
- 使用 Micronaut 測試框架
- 測試本地和獨立兩種模式

### 前端測試
- 使用 Jest 進行單元測試
- 使用 Playwright 進行 E2E 測試
- 使用 Storybook 進行組件測試
- 執行 `npm run test:unit` 和 `npm run test:e2e`

## 插件開發

### 建立插件

- 遵循 [插件開發人員指南](https://kestra.io/docs/plugin-developer-guide/)
- 將 JAR 檔案放置在 `KESTRA_PLUGINS_PATH`
- 使用插件範本結構
- 在本地和獨立兩種模式下進行測試

### 插件載入

- 設置 `KESTRA_PLUGINS_PATH` 環境變數
- 在本地開發時使用 devcontainer 掛載
- 插件在啟動時載入

## 常見問題與解決方案

### JavaScript 堆疊記憶體不足（Heap Out of Memory）

設置 `NODE_OPTIONS=--max-old-space-size=4096` 環境變數。

### CORS 問題

在使用前端開發伺備器時，確保後端 CORS 已配置為允許 `http://localhost:5173`。

### 資料庫連接問題

- 從 devcontainer 連接時，使用 `host.docker.internal` 代替 `localhost`
- 確認 PostgreSQL 正在運行且可訪問
- 檢查資料庫認證資訊和權限

### Gradle 建置問題

- 清除 Gradle 快取：`./gradlew clean`
- 檢查 Java 版本相容性
- 確認所有依賴項均可用

## 拉取請求（Pull Request）指南

### 提交前

1. 執行所有測試：`./gradlew test` 和 `npm test`
2. 檢查代碼格式：`./gradlew spotlessCheck`
3. 如果更改了 API，請驗證 CORS 配置
4. 測試本地和獨立兩種模式
5. 更新面向用戶更改的文件

### 提交訊息（Commit Messages）

- 遵循慣用提交（Conventional Commits）格式
- 使用現在式（例如 "Add feature" 而非 "Added feature"）
- 適用時引用議題編號
- 保持提交內容集中且原子化

### 審查檢查清單

- [ ] 所有測試均通過
- [ ] 代碼遵循專案風格指南
- [ ] 文件已更新
- [ ] 沒有遷移指南的情況下不包含破壞性變更
- [ ] 如果 API 更改，CORS 已正確配置
- [ ] 本地和獨立模式均已測試

## 常用命令

```bash
# 快速開發命令
./gradlew runLocal                    # 啟動本地後端
./gradlew :ui:build                   # 建置前端
./gradlew clean build                 # 清理並重建
npm run dev                           # 啟動前端開發伺服器
make install                          # 在本地安裝 Kestra
make start-standalone-postgres        # 使用 PostgreSQL 啟動

# 測試命令
./gradlew test                        # 執行所有後端測試
./gradlew :core:test                  # 執行特定模組測試
npm run test                          # 執行前端測試
npm run lint                          # 檢查前端代碼
```

## 獲取幫助

- 開啟 [GitHub 議題](https://github.com/kestra-io/kestra/issues)
- 加入 [Kestra Slack 社群](https://kestra.io/slack)
- 查看 [主要文件](https://kestra.io/docs)

## 環境變數

| 變數 | 描述 | 預設值 |
|----------|-------------|---------|
| `MICRONAUT_ENVIRONMENTS` | 自定義配置環境 | `local,override` |
| `KESTRA_PLUGINS_PATH` | 自定義插件路徑 | `/workspaces/kestra/local/plugins` |
| `NODE_OPTIONS` | Node.js 選項 | `--max-old-space-size=4096` |
| `JAVA_HOME` | Java 安裝路徑 | `/usr/java/jdk-21` |

請記住：始終在本地和獨立模式下測試您的更改，並確保為前端開發正確配置了 CORS。
