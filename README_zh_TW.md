<p align="center">
  <a href="https://www.kestra.io">
    <img src="https://kestra.io/banner.png"  alt="Kestra 工作流編排器" />
  </a>
</p>

<h1 align="center" style="border-bottom: none">
    事件驅動的宣告式編排平台
</h1>

<div align="center">
 <a href="https://github.com/kestra-io/kestra/releases"><img src="https://img.shields.io/github/tag-pre/kestra-io/kestra.svg?color=blueviolet" alt="最新版本" /></a>
  <a href="https://github.com/kestra-io/kestra/blob/develop/LICENSE"><img src="https://img.shields.io/github/license/kestra-io/kestra?color=blueviolet" alt="授權協議" /></a>
  <a href="https://github.com/kestra-io/kestra/stargazers"><img src="https://img.shields.io/github/stars/kestra-io/kestra?color=blueviolet&logo=github" alt="Github star" /></a> <br>
<a href="https://kestra.io"><img src="https://img.shields.io/badge/Website-kestra.io-192A4E?color=blueviolet" alt="Kestra 無限可擴展的編排與調度平台"></a>
<a href="https://kestra.io/slack"><img src="https://img.shields.io/badge/Slack-Join%20Community-blueviolet?logo=slack" alt="Slack"></a>
</div>

<p align="center">
  <a href="README.md"><b>English Version</b></a>
</p>

<br />

<p align="center">
  <a href="https://twitter.com/kestra_io" style="margin: 0 10px;">
        <img height="25" src="https://kestra.io/twitter.svg" alt="twitter" width="35" height="25" /></a>
  <a href="https://www.linkedin.com/company/kestra/" style="margin: 0 10px;">
        <img height="25" src="https://kestra.io/linkedin.svg" alt="linkedin" width="35" height="25" /></a> 
  <a href="https://www.youtube.com/@kestra-io" style="margin: 0 10px;">
        <img height="25" src="https://kestra.io/youtube.svg" alt="youtube" width="35" height="25" /></a>
</p>

<p align="center">
  <a href="https://trendshift.io/repositories/2714" target="_blank">
    <img src="https://trendshift.io/api/badge/repositories/2714" alt="kestra-io%2Fkestra | Trendshift" width="250" height="55"/>
  </a>
  <a href="https://www.producthunt.com/posts/kestra?embed=true&utm_source=badge-top-post-badge&utm_medium=badge&utm_souce=badge-kestra" target="_blank"><img src="https://api.producthunt.com/widgets/embed-image/v1/top-post-badge.svg?post_id=612077&theme=light&period=daily&t=1740737506162" alt="Kestra - All&#0045;in&#0045;one&#0032;automation&#0032;&#0038;&#0032;orchestration&#0032;platform | Product Hunt" style="width: 250px; height: 54px;" width="250" height="54" /></a>
</p>

<p align="center">
    <a href="https://go.kestra.io/video/product-overview" target="_blank">
        <img src="https://kestra.io/startvideo.png" alt="在 3 分鐘內開始使用 Kestra" width="640px" />
    </a>
</p>
<p align="center" style="color:grey;"><i>點擊圖片了解如何在 3 分鐘內開始使用 Kestra。</i></p>


## 🌟 什麼是 Kestra？

Kestra 是一個開源、事件驅動的編排平台，讓**定時調度**和**事件驅動**的工作流變得簡單。透過將**基礎設施即代碼 (Infrastructure as Code)** 的最佳實踐引入數據、流程和微服務編排，您只需幾行 YAML 即可直接從 UI 構建可靠的[工作流](https://kestra.io/docs/getting-started)。

**關鍵特性：**
- **一切皆代碼且可從 UI 操作：** 即使從 UI 構建，也能透過 **Git 版本控制**整合將**工作流保持為代碼**。
- **事件驅動與定時工作流：** 透過簡單的 `trigger` 定義，自動化**定時**和**即時**事件驅動的工作流。
- **宣告式 YAML 介面：** 在**內建代碼編輯器**中使用簡單的配置定義工作流。
- **豐富的插件生態系統：** 內建數百個插件，可從任何數據庫、雲端存儲或 API 提取數據，並**以任何語言運行腳本**。
- **直覺的 UI 與代碼編輯器：** 直接從 UI 構建和視覺化工作流，具備語法高亮、自動補全和即時語法驗證功能。
- **可擴展性：** 設計用於處理數百萬個工作流，具備高可用性和容錯能力。
- **版本控制友好：** 從內建代碼編輯器編寫工作流，並直接從 Kestra 推送到您偏好的 Git 分支，實現 CI/CD 流水線和版本控制系統的最佳實踐。
- **結構化與韌性**：透過 **命名空間 (namespaces)**、**標籤 (labels)**、**子流 (subflows)**、**重試 (retries)**、**超時 (timeout)**、**錯誤處理 (error handling)**、在 UI 中生成產物的**輸入 (inputs)** 和 **輸出 (outputs)**、**變數 (variables)**、**條件分支 (conditional branching)**、**進階調度 (advanced scheduling)**、**事件觸發器 (event triggers)**、**補跑 (backfills)**、**動態任務 (dynamic tasks)**、**順序和並行任務 (sequential and parallel tasks)** 來馴服混亂並為工作流帶來韌性。需要時可將 `disabled` 標記設置為 `true` 來跳過任務或觸發器。


🧑‍💻 每當您從 UI 或透過 API 調用對工作流進行更改時，YAML 定義都會自動調整。因此，編排邏輯**始終以代碼形式宣告式管理**，即使您透過其他方式（UI、CI/CD、Terraform、API 調用）修改工作流也是如此。


<p align="center">
  <img src="https://kestra.io/adding-tasks.gif" alt="在 UI 中添加新任務">
</p>

---

## 🚀 快速入門

### 在 AWS 上啟動 (CloudFormation)

使用我們的 CloudFormation 模板在 AWS 上部署 Kestra：

[![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home#/stacks/create/review?templateURL=https://kestra-deployment-templates.s3.eu-west-3.amazonaws.com/aws/cloudformation/ec2-rds-s3/kestra-oss.yaml&stackName=kestra-oss)

### 在 Google Cloud 上啟動 (Terraform 部署)

使用[我們的 Terraform 模組](https://github.com/kestra-io/deployment-templates/tree/main/gcp/terraform/infrastructure-manager/vm-sql-gcs)在 Google Cloud Infrastructure Manager 上部署 Kestra。

### 在 5 分鐘內於本地開始

#### 在 Docker 中啟動 Kestra

確保 Docker 正在運行。然後，使用單個命令啟動 Kestra：

```bash
docker run --pull=always -it -p 8080:8080 --user=root \
  --name kestra --restart=always \
  -v kestra_data:/app/storage \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp:/tmp \
  kestra/kestra:latest server local
```

如果您使用 Windows 且使用 PowerShell：
```powershell
docker run --pull=always -it -p 8080:8080 --user=root `
  --name kestra --restart=always `
  -v "kestra_data:/app/storage" `
  -v "/var/run/docker.sock:/var/run/docker.sock" `
  -v "C:/Temp:/tmp" `
  kestra/kestra:latest server local
```

如果您使用 Windows 且使用命令提示字元 (CMD)：
```cmd
docker run --pull=always -it -p 8080:8080 --user=root ^
  --name kestra --restart=always ^
  -v "kestra_data:/app/storage" ^
  -v "/var/run/docker.sock:/var/run/docker.sock" ^
  -v "C:/Temp:/tmp" ^
  kestra/kestra:latest server local
```

如果您使用 Windows 且使用 WSL (Windows 中的 Linux 環境)：
```bash
docker run --pull=always -it -p 8080:8080 --user=root \
  --name kestra --restart=always \
  -v kestra_data:/app/storage \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  -v "/mnt/c/Temp:/tmp" \
  kestra/kestra:latest server local
```

查看我們的[安裝指南](https://kestra.io/docs/installation)以獲取其他部署選項（Docker Compose、Podman、Kubernetes、AWS、GCP、Azure 等）。

訪問 Kestra UI：[http://localhost:8080](http://localhost:8080) 並開始構建您的第一個流程！

#### 您的第一個 Hello World 流程

創建一個包含以下內容的新流程：

```yaml
id: hello_world
namespace: dev

tasks:
  - id: say_hello
    type: io.kestra.plugin.core.log.Log
    message: "Hello, World!"
```


運行流程並在 UI 中查看輸出！

---

## 🧩 插件生態系統

Kestra 的功能透過豐富的[插件生態系統](https://kestra.io/plugins)得到擴展，使您能夠在任何地方運行任務並以任何語言編寫代碼，包括 Python、Node.js、R、Go、Shell 等。以下是 Kestra 插件如何增強您的工作流：

- **隨處運行：**
  - **本地或遠端執行：** 在本地機器、透過 SSH 在遠端伺服器上執行任務，或使用 [Task Runners](https://kestra.io/docs/task-runners) 擴展到無伺服器容器。
  - **Docker 和 Kubernetes 支持：** 在工作流中無縫運行 Docker 容器，或啟動 Kubernetes 作業來處理計算密集型工作負載。

- **以任何語言編寫代碼：**
  - **腳本支持：** 使用您偏好的編程語言編寫腳本。Kestra 支持 Python、Node.js、R、Go、Shell 等，允許您整合現有的代碼庫和部署模式。
  - **靈活的自動化：** 執行 Shell 命令，對各種數據庫運行 SQL 查詢，並發送 HTTP 請求與 API 互動。

- **事件驅動與即時處理：**
  - **即時觸發器：** 即時響應來自外部系統的事件，例如文件到達、消息總線中的新消息（Kafka、Redis、Pulsar、AMQP、MQTT, NATS、AWS SQS、Google Pub/Sub、Azure Event Hubs）等。
  - **自定義事件：** 定義自定義事件，根據特定條件或外部信號觸發流程，實現高度響應的工作流。

- **雲端整合：**
  - **AWS, Google Cloud, Azure：** 與各種雲端服務整合，與存儲解決方案、消息系統、計算資源等進行互動。
  - **大數據處理：** 使用 Apache Spark 等工具運行大數據處理任務，或與 Google BigQuery 等分析平台互動。

- **監控與通知：**
  - **保持知情：** 將消息發送到 Slack 頻道、發送電子郵件通知，或在 PagerDuty 中觸發警報，讓您的團隊隨時掌握工作流狀態。

Kestra 的插件生態系統正在不斷擴展，允許您根據具體需求量身定制平台。無論您是在編排複雜的數據流水線、在多個環境中自動化腳本，還是與雲端服務整合，都可能有相應的插件提供協助。如果沒有，您隨時可以[構建自己的插件](https://kestra.io/docs/plugin-developer-guide/)來擴展 Kestra 的功能。

🧑‍💻 **注意：** 這只是 Kestra 插件功能的一個縮影。在我們的[插件頁面](https://kestra.io/plugins)探索完整列表。

---

## 📚 核心概念

- **流程 (Flows)：** Kestra 中的核心單元，代表由任務組成的工作流。
- **任務 (Tasks)：** 個別的工作單元，例如運行腳本、移動數據或調用 API。
- **命名空間 (Namespaces)：** 流程的邏輯分組，用於組織和隔離。
- **觸發器 (Triggers)：** 啟動流程執行的調度或事件。
- **輸入與變數 (Inputs & Variables)：** 傳遞到流程和任務中的參數和動態數據。

---

## 🎨 視覺化構建工作流

Kestra 提供直覺的 UI，讓您可以互動式地構建和視覺化工作流：

- **拖放介面：** 從拓撲編輯器中添加和重新排列任務。
- **即時驗證：** 對工作流的語法和結構提供即時反饋，以便儘早發現錯誤。
- **自動補全：** 在您輸入時提供智能建議，以便快速編寫流程代碼且無語法錯誤。
- **即時拓撲視圖：** 將工作流視為有向無環圖 (DAG)，並即時更新。

---


## 🔧 可擴展且開發者友好

### 插件開發

創建自定義插件以擴展 Kestra 的功能。查看我們的[插件開發者指南](https://kestra.io/docs/plugin-developer-guide/)開始使用。

### 基礎設施即代碼

- **版本控制：** 將您的流程存儲在 Git 存儲庫中。
- **CI/CD 整合：** 使用 CI/CD 流水線自動化流程部署。
- **Terraform Provider：** 使用[官方 Terraform provider](https://kestra.io/docs/terraform/) 管理 Kestra 資源。

---

## 🌐 加入社群

保持聯繫並獲得支持：

- **Slack：** 加入我們的 [Slack 社群](https://kestra.io/slack) 提問並分享想法。
- **LinkedIn：** 在 [LinkedIn](https://www.linkedin.com/company/kestra/) 上關注我們 — 除了 Slack 和 GitHub，這是我們分享更新和產品公告的主要渠道。
- **YouTube：** 訂閱我們的 [YouTube 頻道](https://www.youtube.com/@kestra-io) 獲取教育視頻內容。我們每週都會發布新視頻！
- **X：** 如果您仍活躍於 [X](https://x.com/kestra_io)，請關注我們。

---

## 🤝 貢獻

我們歡迎各種形式的貢獻！

- **報告問題：** 發現錯誤或有功能請求？在 [GitHub 上提交 Issue](https://github.com/kestra-io/kestra/issues)。
- **貢獻代碼：** 查看我們的[貢獻者指南](https://kestra.io/docs/contribute-to-kestra)獲取初步準則，並探索我們的 [good first issues](https://go.kestra.io/contributing) 尋找適合初學者的任務。
- **開發插件：** 使用我們的[插件開發者指南](https://kestra.io/docs/plugin-developer-guide/)構建並分享插件。
- **貢獻文件：** 貢獻編輯或更新，以保持我們的[文件](https://github.com/kestra-io/docs)處於頂尖水平。

---

## 📄 授權協議

Kestra 根據 Apache 2.0 許可協議授權 © [Kestra Technologies](https://kestra.io)。

---

## ⭐️ 保持更新

給我們的存儲庫一顆星，以隨時了解最新功能和更新！

[![Star the Repo](https://kestra.io/star.gif)](https://github.com/kestra-io/kestra)

---

感謝您考慮使用 Kestra 來滿足您的工作流編排需求。我們迫不及待想看到您將構建什麼！
