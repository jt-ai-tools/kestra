## 行為準則

此專案及所有參與者均受 [Kestra 行為準則](https://github.com/kestra-io/kestra/blob/develop/.github/CODE_OF_CONDUCT_zh_TW.md) 的約束。參與即代表您預期會維護此準則。請向 <hello@kestra.io> 舉報不可接受的行為。

## 我想要貢獻

> ### 法律聲明
> 在為此專案做出貢獻時，您必須同意您擁有內容 100% 的著作權，且您擁有該內容所需的權利，並且您貢獻的內容可以根據專案授權條款提供。


### 提交議題（Issues）

### 回報錯誤
錯誤回報幫助我們讓 Kestra 對每個人都更好。我們為錯誤提供了一個預先設定好的範本，以便清楚說明我們需要哪些資訊。
在提出新議題之前，請先搜尋我們的 [已回報錯誤](https://github.com/kestra-io/kestra/issues?q=is%3Aissue+is%3Aopen+label%3Abug)，以確保您沒有重複提交。

### 回報安全問題
請不要建立公開的 GitHub 議題。如果您發現了安全性問題，請直接發送電子郵件至 hello@kestra.io，而不要提出議題。


### 請求新功能
要請求新功能，請在此專案中建立一個議題。
如果您想建議新功能，我們請您使用我們的議題範本。它包含幾個關鍵問題，可以幫助我們理解您想要解決的問題，以及您認為您的建議將如何解決該問題。
要查看社群已經提出了哪些建議，您可以看 [這裡](https://github.com/kestra-io/kestra/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)。
請留意重複項！如果您正在建立一個新議題，請檢查現有的未解決或最近關閉的議題。為單一被投票最多的議題設定優先順序對我們來說要容易得多。

### 您的第一次程式碼貢獻

#### 需求
在本地端建置 Kestra 需要以下依賴項：
- Java 25+
- Node 22+ 及 npm 10+
- Python 3, pip 及 python venv
- Docker & Docker Compose
- IDE (Intellij IDEA, Eclipse 或 VS Code)

感謝 Kestra 社群，如果使用 VSCode，您還可以使用引導式 Docker 容器開始開發前端或後端，而無需手動設置環境。

查看 [README](../.devcontainer/README_zh_TW.md) 以獲取設置說明以及儲存庫中相關的 [Dockerfile](../.devcontainer/Dockerfile) 以開始。

開始貢獻：
- [Fork](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo) 儲存庫
- 在您的工作站上複製 fork 的儲存庫：

```shell
git clone git@github.com:{YOUR_USERNAME}/kestra.git
cd kestra
```

#### 後端開發
後端是使用 [Micronaut](https://micronaut.io) 製作的。

在您喜歡的 IDE 中開啟複製的儲存庫。在大多數優秀的 IDE 中，會自動偵測到 Gradle 建置並下載所有依賴項。
您也可以使用終端機透過 `./gradlew build` 進行建置，Gradle 包裝器（wrapper）將下載正確的 Gradle 版本供使用。

- 您可能需要啟用 Java 註解處理器（annotation processors），因為我們有使用它們。
- 在 IntelliJ IDEA 上，點擊 **Run -> Edit Configurations -> + Add new Configuration** 來建立一個運行配置以啟動 Kestra。
  - 主類別（Main class）是來自模組 `kestra.cli.main` 的 `io.kestra.cli.App`。
  - 將您想要使用的伺服器作為程式參數傳遞，例如 `server local` 將啟動 [獨立本地伺服器](https://kestra.io/docs/administrator-guide/server-cli#kestra-local-development-server-with-no-dependencies)。您也可以使用 `server standalone` 並使用提供的 `docker-compose-ci.yml` Docker compose 檔案來啟動一個帶有真實資料庫作為後端的獨立伺服器，這需要進行適當的配置。
  - 配置以下環境變數：
    - `MICRONAUT_ENVIRONMENTS`：可以設置為任何字串，並將載入 `cli/src/main/resources/application-{env}.yml` 中的自定義配置檔案。
    - `KESTRA_PLUGINS_PATH`：是您將插件保存為 Jar 的路徑，並將在啟動時載入。
  - 範例請參見下方截圖：![Intellij IDEA 配置 ](./assets/run-app.png)
  - 如果您在啟動期間遇到 **JavaScript memory heap out** 錯誤，請為 `NODE_OPTIONS` 環境變數配置較大的值。
      - 範例 `NODE_OPTIONS: --max-old-space-size=4096` 或 `NODE_OPTIONS: --max-old-space-size=8192` ![Intellij IDEA 配置 ](./assets/node_option_env_var.png)
- 伺服器預設在 8080 埠啟動，可透過 `http://localhost:8080` 訪問。

如果您想啟動所有測試，您的機器上需要安裝 Python 和一些軟體包。在 Ubuntu 上，您可以透過以下方式安裝：

```shell
sudo apt install python3 pip python3-venv
python3 -m pip install virtualenv
```


#### 前端開發
前端是使用 [Vue.js](https://vuejs.org/) 製作的，位於 `/ui` 資料夾中。

- `npm install`
- `npm run dev` 將啟動帶有熱重載（hot reload）的開發伺服器。
- 伺服器預設在 5173 埠啟動，可透過 `http://localhost:5173` 訪問。
- 您可以執行 `npm run build` 來建置前端，該前端將由後端提供（無需執行上述 `npm run dev`）。

現在，您需要啟動一個後端伺服器，您可以：
- 使用此已配置並啟用 CORS 的 docker-compose 檔案啟動一個不帶資料庫的 [本地伺服器](https://kestra.io/docs/administrator-guide/server-cli#kestra-local-development-server-with-no-dependencies)：
```yaml
services:
  kestra:
    image: kestra/kestra:latest
    user: "root"
    command: server local
    environment:
      KESTRA_CONFIGURATION: |
        micronaut:
          server:
            cors:
              enabled: true
              configurations:
                all:
                  allowedOrigins:
                    - http://localhost:5173
    ports:
      - "8080:8080"
```
- 從您的 IDE 啟動 [後端開發](#後端開發) 從您的 IDE，您需要配置 CORS 限制，在使用本地開發 npm 伺服器時，更改後端配置以允許 `cli/src/main/resources/application-override.yml` 中的 http://localhost:5173 來源。

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

#### 在本地建置並部署 Kestra

出於測試目的，您可以使用專案根目錄提供的 `Makefile` 在本地建置並部署 Kestra。
預設情況下，Kestra 將安裝在：`$HOME/.kestra/current`。設置 `KESTRA_HOME` 環境變數以覆蓋預設值。

```bash
# 建置並安裝 Kestra
make install
# 安裝插件（插件安裝基於 API）。
make install-plugins
# 以帶有 Postgres 作為後端的獨立模式啟動 Kestra
make start-standalone-postgres
```

注意：本地安裝會將日誌寫入 `~/.kestra/current/logs/` 目錄。

#### 開發插件
開發插件的完整文檔可以在 [這裡](https://kestra.io/docs/plugin-developer-guide/) 找到。

### 改進文件
主要文件位於一個獨立的 [儲存庫](https://github.com/kestra-io/kestra.io) 中。
對於任務文件，它們直接位於 Java 源代碼中，使用 [Swagger 註解](https://github.com/swagger-api/swagger-core/wiki/Swagger-2.X---Annotations)（範例：[用於 Bash 任務](https://github.com/kestra-io/kestra/blob/develop/core/src/main/java/io/kestra/core/tasks/scripts/AbstractBash.java)）
