# Kestra UI

Kestra UI 使用 [Vite](https://vite.dev/) 運行。

---

## 說明

### 開發：
- （選填）預設情況下，您的開發伺服器將目標設定為 `localhost:8080`。如果您的後端在其他地方運行，您可以在 `ui` 資料夾下建立 `.env.development.local`，內容如下：
```
VITE_APP_API_URL={myApiUrl}
```

- 進入 `ui` 資料夾並執行 `npm install` 以安裝前端專案的依賴項目。

- 現在前往 `cli/src/main/resources` 資料夾並建立 `application-override.yml` 檔案。

您現在有兩個選擇：

`本地模式 (Local mode)`：

以本地模式執行 Kestra 伺服器，使用 H2 資料庫，因此您只需要這項配置：

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

然後您可以開啟一個新的終端機並執行以下命令來啟動後端伺服器：`./gradlew runLocal`

`獨立模式 (Standalone mode)`：

以獨立模式執行，使用 Postgres。請確保 `localhost` 上已有正在運行的本地 Postgres 實例：

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
    # 值得注意的是，在連接到開發容器之外的 docker 容器時，您必須使用 "host.docker.internal" 主機，因為嘗試使用 localhost 只會指向此開發容器。
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
      # 我們必須忽略遺失的遷移，因為我們可能會刪除錯誤的遷移或不再使用的遷移。
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

如果您正在進行前端開發，在上述環境運行後（將提供後端），您可以從 `ui` 資料夾執行 `npm run dev`，透過 `localhost:5173` 存取您的應用程式。這樣的好處是可以監看您的變更，並在進行前端變更時進行熱重載 (hot-reload)。
