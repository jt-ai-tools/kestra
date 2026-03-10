# Kestra 開發容器 (Devcontainer)

此開發容器為使用 VSCode 的任何人提供了一個快速簡便的設定，讓您可以迅速啟動並執行此專案，開始進行前端或後端的開發。它會為您引導 (bootstrap) 一個 Docker 容器，讓您在其中進行開發，而無需手動設定環境。

---

## 說明 (INSTRUCTIONS)

### 設定 (Setup)：

請參考此指南以瞭解設定方式，因為此開發容器設定遵循此方法：https://kestra.io/docs/contribute-to-kestra

將此儲存庫複製到本地系統後，您需要安裝 VSCode 擴充功能 [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)。

然後從命令面板 (command palette) 執行以下命令：
`Dev Containers: Open Folder in Container...` 並選擇您的 Kestra 根資料夾。

這將使您進入一個準備好進行開發的 Docker 容器中。

注意：您需要等待 Gradle 建置完成並編譯 Java 檔案，但此過程應該會在 VSCode 中自動發生。

與此同時，您可以進行下一步...

---

### 需求 (Requirements)

- Java 25 (LTS 版本)。
- Gradle (隨附包裝器 `./gradlew`)
- Docker (選用，用於在容器中執行 Kestra)

### 開發 (Development)：

- 進入 `ui` 資料夾並執行 `npm install` 以安裝前端專案的依賴項。

- 現在前往 `cli/src/main/resources` 資料夾並建立一個 `application-override.yml` 檔案。

現在您有兩個選擇：

`本地模式 (Local mode)`：

在本地模式下執行 Kestra 伺服器，該模式使用 H2 資料庫，因此這是您唯一需要的設定：

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

然後，您可以打開一個新終端機並執行以下命令來啟動後端伺服器：`./gradlew runLocal`

`獨立模式 (Standalone mode)`：

在獨立模式下執行，該模式使用 Postgres。請確保本地已在 localhost 上執行一個 Postgres 實例：

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
    # 重要的是要注意，連接到開發容器之外的 Docker 容器時，必須使用 "host.docker.internal" 主機，因為嘗試使用 localhost 只會指向回此開發容器。
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
      # 我們必須忽略缺失的遷移，因為我們可能會刪除錯誤的遷移或刪除不再使用的遷移。
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

然後將以下設定添加到 `.vscode/launch.json` 檔案中：

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Kestra Standalone",
      "request": "launch",
      "mainClass": "io.kestra.cli.App",
      "projectName": "cli",
      "args": "server standalone"
    }
  ]
}
```

然後，您可以使用 VSCode 的「執行與偵錯」 (Run and Debug) 擴充功能來啟動 Kestra 伺服器。

此外，如果您正在進行前端開發，在上述內容執行後（這將提供後端），您可以從 `ui` 資料夾執行 `npm run dev`，以便從 `localhost:5173` 訪問您的應用程式。這樣的好處是可以監看您的更改，並在進行前端更改時進行熱重載 (hot-reload)。

#### 插件 (Plugins)
如果您希望在開發容器中載入插件，請在 `devcontainer.json` 的以下程式碼片段中，將 `source` 欄位指向包含您要嵌入插件的 JAR 檔案資料夾：
```
"mounts": [
  {
    "source": "/absolute/path/to/your/local/jar/plugins/folder",
    "target": "/workspaces/kestra/local/plugins",
    "type": "bind"
  }
],
```

---

### GIT

如果您想提交到 GitHub，請務必進入 `~/.ssh` 資料夾，建立一個新的 SSH 金鑰或覆蓋現有的 `id_ed25519` 檔案，並將本地機器上現有的 SSH 金鑰貼上到此檔案中。然後，您需要透過執行以下命令來更改檔案權限：`chmod 600 id_ed25519`。這將允許您推送到 GitHub。

---
