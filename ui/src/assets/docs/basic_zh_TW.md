### 流程屬性 (Flow properties)

Kestra 讓您使用簡單的 YAML 語法定義並自動化流程。每個流程都需要一個 `id`、`namespace` (命名空間) 和 `tasks` (任務)。其他欄位如 `triggers` (觸發器)、`labels` (標籤)、`inputs` (輸入) 等則是選填的。

展開以閱讀更多關於這些流程屬性的資訊。

| 屬性 | 描述 |
|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id` | [流程識別碼](https://kestra.io/docs/workflow-components/flow)，代表流程的名稱。此 ID 在命名空間內必須是唯一的，且不可變更（您之後無法重新命名流程 ID，但可以用新名稱重新建立）。 |
| `namespace` | 每個流程都存在於一個 [命名空間](https://kestra.io/docs/workflow-components/namespace) 中。命名空間用於對流程進行分組並提供結構。Kestra 中的某些概念，例如 [命名空間檔案 (Namespace Files)](https://kestra.io/docs/concepts/namespace-files) 或 [鍵值存儲 (KV Store)](https://kestra.io/docs/concepts/kv-store)，都與命名空間綁定。建立後無法變更流程的命名空間；請使用所需的命名空間建立新流程，並刪除舊流程。 |
| `tasks` | 要執行的 [任務](https://kestra.io/docs/workflow-components/tasks) 清單。任務是流程中的原子操作。預設情況下，它們將一個接一個地按順序執行。但是，您可以使用額外的 [可流程化任務 (Flowable tasks)](https://kestra.io/docs/tutorial/flowable) 來平行執行某些任務。 |
| `inputs` | 強型別 [輸入](https://kestra.io/docs/workflow-components/inputs) 清單，可讓您的流程更加動態且可重複使用。與其在流程中硬編碼數值，您可以使用輸入以不同的數值執行多次流程，數值在執行階段確定。使用語法 `{{ inputs.your_input_name }}` 在任務中存取特定的輸入值。 |
| `outputs` | 每個流程都可以 [產生輸出](https://kestra.io/docs/workflow-components/outputs)，供其他流程使用。這是一個清單屬性，因此您的流程可以根據需要產生多個 [輸出](https://kestra.io/docs/workflow-components/outputs)。每個輸出都需要一個 `id`（輸出名稱）、一個 `type`（與 `inputs` 中相同的類型，例如 `STRING`、`URI` 或 `JSON`）和 `value`（實際的輸出值，將儲存在內部存儲中，並在需要時傳遞給其他流程）。 |
| `labels` | 您可以用來根據專案、維護者或任何其他標準來組織流程的鍵值對 (Key-value pairs)。您可以使用 [標籤 (labels)](https://kestra.io/docs/workflow-components/labels) 在 UI 中篩選執行紀錄 (Executions)。 |
| `description` | 流程的 [描述](https://kestra.io/docs/workflow-components/descriptions)。 |
| `checks` | [`checks`](https://kestra.io/docs/workflow-components/checks) 是流程層級的斷言 (assertions)，在驗證輸入時以及建立新執行之前進行評估。 |
| `variables` | [變數](https://kestra.io/docs/workflow-components/variables) 清單（例如 API 端點、資料表名稱、下載網址等），您可以使用語法 `{{ vars.your_variable_name }}` 在任務中存取。變數有助於跨任務重複使用某些數值。 |
| `sla` | [SLA 條件](https://kestra.io/docs/workflow-components/sla) 清單，指定如果工作流不滿足 SLA 中定義的斷言時的執行 `behavior` (行為)。 |
| `errors` | 如果當前執行發生錯誤，將執行的 [錯誤任務 (error tasks)](https://kestra.io/docs/workflow-components/errors) 清單。 |
| `finally` | 工作流完成後將執行的 [最終任務 (finally tasks)](https://kestra.io/docs/workflow-components/finally) 清單。無論工作流成功與否，這些任務都會執行。 |
| `afterExecution` | 執行結束後將執行的 [afterExecution](https://kestra.io/docs/workflow-components/afterexecution) 任務清單，無論最終狀態為何。這些任務將在工作流執行達到最終狀態後執行，包括 `finally` 區塊中任務的執行。 |
| `disabled` | 將其設定為 `true` 以暫時 [停用 (disable)](https://kestra.io/docs/workflow-components/disabled) 該流程的任何新執行。當您想停止流程執行（即使是手動執行）而不刪除它時，這非常有用。一旦您將此屬性設為 true，除非將此屬性設回 `false`（預設行為）或刪除此屬性以重新啟用流程，否則任何人都無法透過 UI 或 API 呼叫來建立該流程的任何執行。 |
| `revision` | [流程修訂版本](https://kestra.io/docs/concepts/revision)，由 Kestra 內部管理，每次修改都會增加。您 **不應** 手動設定它。 |
| `triggers` | [觸發器](https://kestra.io/docs/workflow-components/triggers) 清單，根據事件（例如排程日期、新檔案到達、隊列中的新訊息或另一個流程執行的完成事件）自動啟動流程執行。 |
| `pluginDefaults` | [預設值](https://kestra.io/docs/workflow-components/plugin-defaults) 清單，讓您避免重複相同的插件屬性。使用 `values`，您可以設定預設屬性。`type` 是完整的 Java 類別名稱，例如 `io.kestra.plugin.core.log.Log`，但您可以使用前綴，例如 `io.kestra`，將某些屬性套用於所有任務。如果 `forced` 設定為 `true`，`pluginDefault` 將優先於任務中定義的屬性（預設行為為 `forced: false`）。 |
| `concurrency` | 透過設定 `limit` 鍵來控制給定流程的 [並行執行](https://kestra.io/docs/workflow-components/concurrency) 數量。超出該限制的執行預設將進入隊列 —— 您可以透過配置 `behavior` 屬性來自定義，該屬性可以設定為 `QUEUE` (預設)、`CANCEL` 或 `FAIL`。 |
| `retry` | 設定流程層級的 `retry` (重試) 策略，在任何任務失敗時重新啟動執行。重試 `behavior` 是可自定義的 —— 您可以選擇 `CREATE_NEW_EXECUTION` (建立新執行) 或 `RETRY_FAILED_TASK` (重試失敗任務，預設)。僅在 `CREATE_NEW_EXECUTION` 行為下，執行的 `attempt` (嘗試次數) 會增加。否則，僅重新啟動失敗的任務執行（增加任務執行的嘗試次數而非流程執行的嘗試次數）。除了 `behavior` 屬性外，`retry` 策略與 [任務重試 (task retries)](https://kestra.io/docs/workflow-components/retries) 相同。 |

### 插件文件 (Plugin documentation)

要檢查 **特定插件** 的屬性，請在編輯器中按一下該任務、觸發器或插件程式碼的任何位置。插件文件將在此視圖中載入。

### 任務屬性 (Task properties)

每個流程都由 **tasks (任務)** 組成。以下核心屬性適用於所有任務。

| 屬性 | 描述 |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id` | 任務的唯一識別碼 |
| `type` | 代表任務類型的完整 Java 類別名稱 |
| `description` | 您自定義的任務功能 [文件描述](https://kestra.io/docs/workflow-components/descriptions) |
| `retry` | 發生失敗時應重試任務的頻率，以及 [重試策略類型](https://kestra.io/docs/workflow-components/retries) |
| `timeout` | 任務允許完成的 [最大時間](https://kestra.io/docs/workflow-components/timeout) |
| `runIf` | 如果提供的條件評估為 false，則跳過任務 |
| `disabled` | 布林旗標，指示任務是否 [被停用](https://kestra.io/docs/workflow-components/disabled)；如果設定為 `true`，任務將在執行期間被跳過 |
| `workerGroup` | 符合執行任務條件的 [工作者組別 (worker group)](https://kestra.io/docs/enterprise/worker-group)（僅限企業版）；您可以指定 `workerGroup.key` 和 `workerGroup.fallback`（預設為 `WAIT`） |
| `allowFailure` | 布林旗標，允許即使此任務失敗也繼續執行 |
| `allowWarning` | 布林旗標，允許即使有警告 (Warnings) 也將任務執行標記為成功 (Success) |
| `logLevel` | 要儲存的日誌詳細程度 |
| `logToFile` | 一個布林值，讓您可以將日誌作為檔案儲存在內部存儲中。可以從日誌 (Logs) 和甘特圖 (Gantt) 執行分頁預覽並下載該檔案。設定為 `true` 時，日誌不會儲存在資料庫中，這對於產生大量日誌、否則會佔用過多空間的任務非常有用。同樣的屬性也可以設定在觸發器上。 |


### 輸入類型 (Input types)

Kestra 中的輸入是強型別的。每種類型都定義了如何在 UI 中輸入、驗證和渲染數值。以下是所有支援的輸入類型及其驗證規則。

| 屬性 | 描述 |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `STRING` | 任何字串值。數值不經過解析直接傳遞。您可以新增 `validator` 正規表達式進行自定義驗證。 |
| `INT` | 不含小數的整數。支援 `min` 和 `max` 驗證以強制執行數值範圍。例如：`42`。 |
| `FLOAT` | 包含小數的浮點數。支援 `min` 和 `max` 驗證。例如：`3.14`。 |
| `BOOL` | 布林旗標，必須為 `true` 或 `false`。避免使用等效的純量值，如 `yes`/`no`，因為 API 和 UI 預期 `true` 或 `false`。 |
| `SELECT` | 從預定義清單中選擇單個值，清單可以是靜態的 `values` 或透過 `expression` (運算式) 定義的動態清單，運算式可以使用 `kv()` 或 `http()` 函數。支援 `allowCustomValue` 讓使用者輸入自定義值，以及 `autoSelectFirst` 預先選擇第一項。 |
| `MULTISELECT` | 從預定義清單中選擇一個或多個值，清單可以是靜態的 `values` 或透過 `expression` 定義的動態清單，運算式可以使用 `kv()` 或 `http()` 函數。支援 `allowCustomValue` 讓使用者輸入自定義值，以及 `autoSelectFirst` 預先選擇第一項。 |
| `DATE` | ISO-8601 日期 (`YYYY-MM-DD`)。支援 `after` 和 `before` 驗證以強制執行有效範圍。例如：`2042-12-28`。 |
| `TIME` | 不含時區的 ISO-8601 時間 (`HH:MM:SS`)。支援 `after` 和 `before` 驗證。例如：`10:15:30`。 |
| `DATETIME` | UTC 格式包含時區的 ISO-8601 日期時間 (`YYYY-MM-DDTHH:MM:SSZ`)。支援 `after` 和 `before` 驗證。例如：`2042-04-02T04:20:42.000Z`。 |
| `DURATION` | ISO-8601 持續時間字串，例如 `PT5M6S`。支援 `min` 和 `max` 持續時間邊界。 |
| `FILE` | 透過 `multipart/form-data` 上傳檔案。上傳的檔案儲存在 Kestra 的內部存儲中，並呈現為 `kestra:///...` URI。您可以使用協議將命名空間檔案作為 `defaults` (預設值) 傳遞：`defaults: nsfile:///hello.txt`。 |
| `JSON` | 有效的 JSON 字串，解析為型別物件。例如：`{"name": "kestra"}`。 |
| `YAML` | 有效的 YAML 字串，解析為型別物件。例如：`- user: John`。 |
| `URI` | 有效的 URI 字串。例如：`https://kestra.io/docs`。 |
| `SECRET` | 儲存在資料庫中的加密字串。在執行階段解密並在 UI/執行上下文中遮罩。需要一個 [加密金鑰 (encryption key)](https://kestra.io/docs/configuration#encryption)。 |
| `ARRAY` | JSON 陣列或 YAML 清單。必須定義 `itemType`（例如 `INT`、`STRING`、`DATETIME`）。每個項目都會根據其類型進行驗證。預設範例：`[1, 2, 3]` 或 YAML 清單。 |


### 輸入屬性 (Input properties)

所有輸入類型都共用一組屬性。這些屬性定義了輸入的行為、是否必填以及它們在 UI 中的外觀。

| 屬性 | 描述 |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id` | 輸入的唯一識別碼。用於在執行階段存取輸入，例如 `{{ inputs.myInput }}`。 |
| `type` | 輸入類型，從支援的清單中選擇，例如 `STRING`、`INT`、`FLOAT` 等。 |
| `required` | 是否必須提供輸入。如果 `required: true`，執行時必須有一個值，可以是在執行階段提供或透過 `defaults` 提供。 |
| `defaults` | 如果執行階段未提供值，則使用的預設值。必須與宣告的類型相符。 |
| `dependsOn` | 使此輸入依賴於一個 `inputs` 陣列，並帶有選填的 `condition` (條件)，以便僅在需要時在 UI 中顯示輸入。 |
| `displayName` | UI 中輸入項的人類可讀標籤。 |
| `description` | 執行流程時在 UI 中渲染的 Markdown 描述。 |
| `expression` | 用於獲取動態數值的 Pebble 運算式，例如使用 `kv()` 或 `http()` 函數。常用於 `SELECT` 或 `MULTISELECT`。 |
| `autoSelectFirst` | 如果為 `true`，當未設定預設值時，自動從下拉選單中選擇第一個選項（適用於 `SELECT` 和 `MULTISELECT`）。 |


### 流程範例 (Flow example)

以下是一個範例流程，展示如何使用 `labels`、`inputs`、`variables`、`triggers` 和 `description`。

```yaml
id: getting_started
namespace: company.team
description: 讓我們 `寫` 一些 **markdown**

labels:
  team: data
  owner: kestrel
  project: falco
  environment: dev
  country: US

inputs:
  - id: user
    type: STRING
    required: false
    prefill: Kestrel
    description: 這是一個選填輸入 —— 如果在執行階段未設定，它將使用預設值 Kestrel

  - id: run_task
    type: BOOL
    defaults: true

  - id: pokemon
    type: MULTISELECT
    displayName: 選擇您最喜歡的寶可夢
    description: 您可以選擇多個！
    values:
      - Pikachu
      - Charizard
      - Bulbasaur
      - Psyduck
      - Squirtle
      - Mewtwo
      - Snorlax
    dependsOn:
      inputs:
        - run_task
      condition: "{{ inputs.run_task }}"

  - id: bird
    type: SELECT
    displayName: 選擇您最喜歡的 Falco 鳥類
    values:
      - Kestrel
      - Merlin
      - Peregrine Falcon
      - American Kestrel
    dependsOn:
      inputs:
        - user
      condition: "{{ inputs.user == 'Kestrel' }}"

variables:
  first: 1
  second: "{{ vars.first }} < 2"

tasks:
  - id: hello
    type: io.kestra.plugin.core.log.Log
    description: 這是 *任務* 文件
    message: |
      我們使用的變數是 {{ vars.first }} 和 {{ render(vars.second) }}。
      輸入是 {{ inputs.user }}，任務在 {{ taskrun.startDate }} 從流程 {{ flow.id }} 啟動。

  - id: run_if_true
    type: io.kestra.plugin.core.debug.Return
    format: Hello World!
    runIf: "{{ inputs.run_task }}"

  - id: fallback
    type: io.kestra.plugin.core.debug.Return
    format: fallback output

finally:
  - id: finally_log
    type: io.kestra.plugin.core.log.Log
    message: "此任務在所有任務執行後執行，無論任務執行成功或失敗。執行狀態 {{ execution.state }}" # Execution RUNNING

afterExecution:
  - id: afterExecution_log
    type: io.kestra.plugin.core.log.Log
    message: "此任務在流程執行完成後執行。執行狀態 {{ execution.state }}" # Execution FAILED / SUCCESS

outputs:
  - id: flow_output
    type: STRING
    value: "{{ tasks.run_if_true.state != 'SKIPPED' ? outputs.run_if_true.value : outputs.fallback.value }}"

pluginDefaults:
  - type: io.kestra.plugin.core.log.Log
    values:
      level: TRACE

triggers:
  - id: monthly
    type: io.kestra.plugin.core.trigger.Schedule
    cron: "0 9 1 * *" # 每月 1 號上午 9 點
```

您可以使用 `description` 屬性為流程、任務、輸入或觸發器編寫文件。這些描述在 UI 中使用 [Markdown](https://zh.wikipedia.org/wiki/Markdown) 渲染。

### Pebble 模板 (Pebble templating)

Kestra 擁有 [Pebble 模板引擎](https://kestra.io/docs/concepts/pebble)，讓您可以在執行上下文中，使用 [Pebble 運算式](https://kestra.io/docs/concepts/expression) 動態渲染變數、輸入和輸出。例如，`{{ flow.namespace }}` 運算式允許存取當前流程的命名空間，而 `{{ printContext() }}` 函數允許您列印執行的整個上下文，這對於調試非常有用。

### Pebble 函數、過濾器和標籤 (Pebble functions, filters and tags)

| 過濾器 | 範例與描述 |
|------------------|----------------------------------------------------------------------------------------------------------------------------------|
| `abs` | `{{ -7 \| abs }}` — 返回 -7 的絕對值，結果為 7。 |
| `abbreviate` | `{{ "this is a long sentence." \| abbreviate(7) }}` — 使用省略號縮短字串。長度包含省略號。可以與其他過濾器串聯：`{{ "apple" \| upper \| abbreviate(3) }}`。 |
| `appLink` | `{{ appLink('yourAppId') }}` — 獲取與當前執行相關聯的 App (僅限企業版) 的 URL。要獲取允許建立新執行的 App 基礎 URL，請新增 `baseUrl=true`，例如 `{{ appLink('yourAppId', baseUrl=true) }}`。如果流程只關聯了一個 App，您可以省略 App ID 參數，例如 `{{ appLink() }}`。 |
| `base64Decode` | `{{ "aGVsbG8=" \| base64Decode }}` — 解碼 base64 字串，結果為 "hello"。 |
| `base64decode` | `{{ "dGVzdA==" \| base64decode }}` — 將 base64 編碼的字串解碼為 UTF-8。 |
| `base64Encode` | `{{ "hello" \| base64Encode }}` — 將字串編碼為 base64，結果為 "aGVsbG8="。 |
| `base64encode` | `{{ "test" \| base64encode }}` — 將字串編碼為 base64。 |
| `block` | `{{ block("post") }}` — 渲染模板中 "post" 區塊的內容 `{% block header %} Introduction {% endblock %}` |
| `capitalize` | `{{ "hello" \| capitalize }}` — 將第一個字母大寫，結果為 "Hello"。 |
| `for` | `{% for user in users %}{{ loop.index }} - {{ user.id }}{% endfor %}` — 在模板中迭代數值清單。支援用於空集合的 else 區塊：`{% for user in users %} ... {% else %} ... {% endfor %}`。 |
| `if` | `{% if users is empty %} ... {% endif %}` — 模板中基於運算式的條件區塊。支援多個分支：`{% if category == "news" %} ... {% elseif category == "sports" %} ... {% else %} ... {% endif %}`。 |
| `macro` | `{% macro input(type, name) %} ... {% endmacro %}` — 建立可重複使用的模板片段。像函數一樣呼叫：`{{ input("text", name="Mitchell") }}`。 |
| `raw` | `{% raw %}{{ user.name }}{% endraw %}` — 編寫一段不會在模板中被解析的語法區塊。 |
| `set` | `{% set header = "Test Page" %}` — 在模板的當前上下文中定義一個變數。 |
| `chunk` | `{{ [1, 2, 3, 4] \| chunk(2) }}` — 將清單拆分為大小為 2 的區塊，結果為 [[1, 2], [3, 4]]。 |
| `className` | `{{ "12.3" \| number \| className }}` — 返回物件的類別名稱。 |
| `contains` | `{{ ["apple", "pear", "banana"] contains "apple" }}` — 檢查集合是否包含特定項目。 |
| `currentEachOutput` | `{{ currentEachOutput(outputs.first) }}` — 檢索同級任務的當前輸出。 |
| `date` | `{{ execution.startDate \| date("yyyy-MM-dd") }}` — 將日期格式化為 "yyyy-MM-dd"。可以使用具名參數：`{{ stringDate \| date('yyyy/MMMM/d', existingFormat='yyyy-MMMM-d') }}`。可以格式化帶有時區的時間戳記：`{{ 1378653552123 \| date(format="iso_milli", timeZone="Europe/Paris") }}`。 |
| `dateAdd` | `{{ execution.startDate \| dateAdd(1, "DAYS") }}` — 在日期上增加 1 天。可以與空值合併運算子一起使用：`{{ trigger.date ?? execution.startDate \| dateAdd(-1, 'DAYS') }}`。 |
| `default` | `{{ myVar \| default("default value") }}` — 如果 `myVar` 為 null 或空，則返回 "default value"。 |
| `distinct` | `{{ ['1', '1', '2', '3'] \| distinct }}` — 返回唯一元素清單，結果為 [1, 2, 3]。 |
| `escapeChar` | `{{ "Can't be here" \| escapeChar('single') }}` — 轉義字串中的特殊字元。 |
| `errorLogs` | `{{ errorLogs() }}` — 列印當前執行的所有錯誤日誌。 |
| `fileExists` | `{{ fileExists(output.download.uri) }}` — 如果檔案存在於給定的 uri 位置，則返回 true。 |
| `fileSize` | `{{ fileSize(output.download.uri) }}` — 返回給定 uri 位置處檔案的大小。 |
| `filter` | `{% filter upper %}hello{% endfilter %}` — 將過濾器套用於模板內容區塊。 |
| `first` | `{{ [1, 2, 3] \| first }}` — 返回清單的第一個元素，結果為 1。 |
| `flatten` | `{{ [[1, 2], [3, 4]] \| flatten }}` — 展開巢狀清單，結果為 [1, 2, 3, 4]。 |
| `fromIon` | `{{ fromIon(read(someItem)).someField }}` — 將 ION 字串轉換為物件並存取其屬性。 |
| `fromJson` | `{{ fromJson('{"foo": [666, 1, 2]}').foo[0] }}` — 將 JSON 字串轉換為物件並存取其屬性。 |
| `http` | `{{ http(uri = 'https://dummyjson.com/products/categories') }}` — 直接從外部 API 獲取數據。 |
| `indent` | `{{ "Hello\nworld" \| indent(4) }}` — 在除第一行外的每行前增加 4 個空格，結果為 "Hello\n    world"。 |
| `isFileEmpty` | `{{ isFileEmpty(output.download.uri) }}` — 如果給定 uri 位置處的檔案為空，則返回 true。 |
| `isIn` | `{{ execution.state isIn ['SUCCESS', 'KILLED', 'CANCELLED'] }}` — 如果左側的值存在於右側清單中，則返回 true。適用於 `runIf` 等條件。 |
| `is defined` | `{% if missing is not defined %} ... {% endif %}` — 檢查變數是否在模板中已定義。 |
| `is empty` | `{% if user.email is empty %} ... {% endif %}` — 檢查變數在模板中是否為空。 |
| `is even` | `{% if 2 is even %} ... {% endif %}` — 檢查模板中的整數是否為偶數。 |
| `is iterable` | `{% if users is iterable %} ... {% endif %}` — 檢查變數在模板中是否為可迭代的。 |
| `is json` | `{% if '{"test": 1}' is json %} ... {% endif %}` — 檢查變數在模板中是否為有效的 JSON 字串。 |
| `is map` | `{% if {"apple":"red", "banana":"yellow"} is map %} ... {% endif %}` — 檢查變數在模板中是否為 map (映射)。 |
| `is null` | `{% if user.email is null %} ... {% endif %}` — 檢查變數在模板中是否為 null。 |
| `is not even` | `{% if 3 is not even %} ... {% endif %}` — 在模板中否定布林運算式。 |
| `is odd` | `{% if 3 is odd %} ... {% endif %}` — 檢查模板中的整數是否為奇數。 |
| `join` | `{{ ["a", "b", "c"] \| join(",") }}` — 將清單連接成字串，結果為 "a,b,c"。 |
| `jq` | `{{ myObject \| jq(".foo") }}` — 應用 JQ 運算式從 `myObject` 中提取 "foo" 屬性。 |
| `keys` | `{{ {"a": 1, "b": 2} \| keys }}` — 返回 map 的鍵，結果為 ["a", "b"]。 |
| `kv` | 預設情況下，從當前命名空間檢索 KV 對：`{{ kv('MY_KEY') }}`。如果提供命名空間作為第二個參數，則從該命名空間檢索：`{{ kv('MY_KEY', 'company.team') }}`。也可以使用具名參數來指定錯誤處理：`{{ kv(key='KEY_ID', namespace='NAMESPACE_ID', errorOnMissing=false) }}` 在鍵缺失時返回 null 而不是報錯。 |
| `last` | `{{ [1, 2, 3] \| last }}` — 返回清單的最後一個元素，結果為 3。 |
| `length` | `{{ "Hello" \| length }}` — 返回 "Hello" 的長度，即 5。 |
| `lower` | `{{ "HELLO" \| lower }}` — 將字串轉換為小寫，結果為 "hello"。 |
| `max` | `{{ max(user.age, 80) }}` — 返回其數值參數中的最大值。 |
| `md5` | `{{ "hello" \| md5 }}` — 計算字串的 MD5 哈希值。 |
| `merge` | `{{ [1, 2] \| merge([3, 4]) }}` — 合併兩個清單，結果為 [1, 2, 3, 4]。 |
| `min` | `{{ min(user.age, 80) }}` — 返回其數值參數中的最小值。 |
| `nindent` | `{{ "Hello\nworld" \| nindent(4) }}` — 增加一個換行符，然後在每行前增加 4 個空格，結果為 "\n    Hello\n    world"。 |
| `number` | `{{ "123" \| number }}` — 將字串 "123" 解析為數字 123。 |
| `numberFormat` | `{{ 12345.6789 \| numberFormat("###,###.##") }}` — 將數字 12345.6789 格式化為 "12,345.68"。 |
| `now` | `{{ now() }}` — 返回當前日期時間。可以指定時區：`{{ now(timeZone='Europe/Paris') }}` 或格式：`{{ now(format='sql_milli') }}`。 |
| `parent` | `{{ parent() }}` — 渲染父區塊的內容。 |
| `printContext` | `{{ printContext() }}` — 列印執行的整個上下文，這對於調試非常有用。 |
| `randomInt` | `{{ randomInt(1, 10) }}` — 從指定範圍內產生一個隨機整數。 |
| `randomPort` | `{{ randomPort() }}` — 產生一個隨機的可用埠號。 |
| `range` | `{{ range(0, 3) }}` — 產生一個從 0 到 3 的清單。 |
| `read` | `{{ read('subdir/file.txt') }}` — 讀取內部存儲檔案並將其內容作為字串返回。 |
| `render` | `{{ render(namespace.github.token) }}` — 遞迴渲染包含 Pebble 運算式的變數。 |
| `renderOnce` | `{{ renderOnce(expression_string) }}` — 僅渲染一次巢狀 Pebble 運算式。 |
| `replace` | `{{ "Hello world!" \| replace({'world': 'Kestra'}) }}` — 將 "world" 替換為 "Kestra"，結果為 "Hello, Kestra!"。 |
| `reverse` | `{{ [1, 2, 3] \| reverse }}` — 反轉清單，結果為 [3, 2, 1]。 |
| `rsort` | `{{ [3, 1, 2] \| rsort }}` — 以相反順序對清單進行排序，結果為 [3, 2, 1]。 |
| `secret` | `{{ secret('MY_SECRET') }}` — 檢索秘密值 `MY_SECRET`。 |
| `sha1` | `{{ "hello" \| sha1 }}` — 計算字串的 SHA-1 哈希值。 |
| `sha256` | `{{ "hello" \| sha256 }}` — 計算字串的 SHA-256 哈希值。 |
| `sha512` | `{{ "hello" \| sha512 }}` — 計算字串的 SHA-512 哈希值。 |
| `slice` | `{{ "Hello, world!" \| slice(0, 5) }}` — 提取子字串，結果為 "Hello"。 |
| `slugify` | `{{ "Hello World!" \| slugify }}` — 將字串轉換為 URL 友善的格式。 |
| `sort` | `{{ [3, 1, 2] \| sort }}` — 以升序對清單進行排序，結果為 [1, 2, 3]。 |
| `split` | `{{ "a,b,c" \| split(",") }}` — 將字串拆分為清單，結果為 ["a", "b", "c"]。 |
| `startsWith` | `{{ "hello world" \| startsWith("hello") }}` — 檢查字串是否以給定前綴開始。 |
| `string` | `{{ 123 \| string }}` — 將 123 轉換為字串。 |
| `substringAfter` | `{{ "a.b.c" \| substringAfter(".") }}` — 提取第一次出現分隔符之後的子字串。 |
| `substringAfterLast` | `{{ "a.b.c" \| substringAfterLast(".") }}` — 提取最後一次出現分隔符之後的子字串。 |
| `substringBefore` | `{{ "a.b.c" \| substringBefore(".") }}` — 提取第一次出現分隔符之前的子字串。 |
| `substringBeforeLast` | `{{ "a.b.c" \| substringBeforeLast(".") }}` — 提取最後一次出現分隔符之前的子字串。 |
| `tasksWithState` | `{{ tasksWithState('failed') }}` — 返回任務及其狀態的映射。 |
| `timestamp` | `{{ execution.startDate \| timestamp }}` — 將日期轉換為以秒為單位的 Unix 時間戳記。 |
| `timestampMicro` | `{{ execution.startDate \| timestampMicro }}` — 將日期轉換為以微秒為單位的 Unix 時間戳記。 |
| `timestampMilli` | `{{ execution.startDate \| timestampMilli }}` — 將日期轉換為以毫秒為單位的 Unix 時間戳記。 |
| `timestampNano` | `{{ execution.startDate \| timestampNano }}` — 將日期轉換為以奈秒為單位的 Unix 時間戳記。 |
| `title` | `{{ "article title" \| title }}` — 將每個單詞的第一個字母大寫。 |
| `toIon` | `{{ myObject \| toIon }}` — 將 `myObject` 轉換為 ION 字串。 |
| `toJson` | `{{ myObject \| toJson }}` — 將 `myObject` 轉換為 JSON 字串。 |
| `trim` | `{{ " Hello " \| trim }}` — 修剪前後空格，結果為 "Hello"。 |
| `upper` | `{{ "hello" \| upper }}` — 將字串轉換為大寫，結果為 "HELLO"。可以與其他過濾器串聯：`{{ "When life gives you lemons, make lemonade." \| upper \| abbreviate(13) }}`。 |
| `urlDecode` | `{{ "a%20b" \| urlDecode }}` — 對字串進行 URL 解碼，結果為 "a b"。 |
| `urlEncode` | `{{ "a b" \| urlEncode }}` — 對字串進行 URL 編碼，結果為 "a%20b"。 |
| `uuid` | `{{ uuid() }}` — 以 Kestra 格式（即以 Url62 編碼的 UUID）產生一個 UUID。 |
| `values` | `{{ {'foo': 'bar', 'baz': 'qux'} \| values }}` — 從 map 中檢索數值。 |
| `yaml` | `{{ yaml('foo: [666, 1, 2]').foo[0] }}` — 將 YAML 字串轉換為物件並存取其屬性。 |


### 常用的 Pebble 運算式 (Common Pebble expressions)

| 運算式 | 描述 |
|----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `{{ flow.id }}` | 流程的識別碼。 |
| `{{ flow.namespace }}` | 流程命名空間的名稱。 |
| `{{ flow.tenantId }}` | 租戶的識別碼。 |
| `{{ flow.revision }}` | 流程的修訂版本。 |
| `{{ execution.id }}` | 執行 ID，為每次執行產生的唯一 ID。 |
| `{{ execution.startDate }}` | 當前執行的開始日期，可以使用 `{{ execution.startDate \| date('yyyy-MM-dd HH:mm:ss.SSSSSS') }}` 進行格式化。 |
| `{{ execution.originalId }}` | 原始執行 ID，此 ID 即使在重播 (replay) 的情況下也不會改變，並保留第一次執行的 ID。 |
| `{{ execution.outputs }}` | 流程輸出中定義的執行輸出，僅在執行終止（`finally` 或 `afterExecution` 區塊）時才填充。 |
| `{{ task.id }}` | 當前任務 ID。 |
| `{{ task.type }}` | 當前任務類型（Java 完整的類別名稱）。 |
| `{{ taskrun.id }}` | 當前任務執行 ID。 |
| `{{ taskrun.startDate }}` | 當前任務執行的開始日期。 |
| `{{ taskrun.parentId }}` | 當前任務執行的父識別碼。僅適用於可流程化任務 (Flowable Task) 內部的任務。 |
| `{{ taskrun.value }}` | 當前任務執行的值，僅適用於可流程化任務內部的任務。 |
| `{{ taskrun.iteration }}` | 當前任務執行迭代的索引，僅適用於可流程化任務內部的任務。 |
| `{{ taskrun.attemptsCount }}` | 當前任務的嘗試次數（執行重試或重新啟動時）。 |
| `{{ parent.taskrun.value }}` | 最近（第一個）父任務執行的值，僅適用於可流程化任務內部的任務。 |
| `{{ parent.outputs }}` | 最近（第一個）父任務執行可流程化任務的輸出，僅適用於封裝在可流程化任務中的任務。 |
| `{{ parents }}` | 父任務清單，僅適用於封裝在可流程化任務中的任務。 |
| `{{ labels }}` | 可透過鍵存取的執行標籤，例如：`{{ labels.myKey1 }}` 返回 `myKey1` 標籤的值。 |
| `{{ trigger.date }}` | 當前排程的日期。 |
| `{{ trigger.next }}` | 下次排程的日期。 |
| `{{ trigger.previous }}` | 上次排程的日期。 |
| `{{ trigger.executionId }}` | 觸發當前流程的執行 ID。 |
| `{{ trigger.namespace }}` | 觸發當前流程的流程命名空間。 |
| `{{ trigger.flowId }}` | 觸發當前流程的流程 ID。 |
| `{{ trigger.flowRevision }}` | 觸發當前流程的流程修訂版本。 |
| `{{ envs.foo }}` | 存取環境變數 `ENV_FOO`（預設帶有前綴 `ENV_`）。 |
| `{{ kestra.environment }}` | 存取環境變數，例如 `kestra.environment.name`。必須在您的 [配置](https://kestra.io/docs/configuration#kestra-url) 中設定才能存取。 |
| `{{ kestra.url }}` | 存取環境 URL 變數。必須在您的 [配置](https://kestra.io/docs/configuration#kestra-url) 中設定才能存取。 |
| `{{ globals.foo }}` | 存取全域變數 `foo`。 |
| `{{ vars.my_variable }}` | 存取流程變數 `my_variable`。 |
| `{{ inputs.myInput }}` | 存取流程輸入 `myInput`。 |
| `{{ namespace.env.name }}` | 存取命名空間變數 `env.name`。 |
| `{{ outputs.taskId.data }}` | 存取名為 `data` 的任務輸出屬性。 |
| `{{ "apple" ~ "pear" ~ "banana" }}` | 連接多個字串，結果為 "applepearbanana"。 |
| `{{ foo == null ? bar : 42 }}` | 如果 `foo` 為 null 則返回 `bar`，否則返回 `42`。 |
| `{{ foo ?? bar ?? baz }}` | 返回第一個非 null 值：如果 `foo` 已定義則返回 `foo`，否則為 `bar` ，否則為 `baz`。 |
| `{# THIS IS A COMMENT #}` | 新增不會出現在輸出中的註解。 |
| `{{ foo.bar }}` | 存取變數的子屬性，例如，如果 `foo = {"bar": "value"}`，則返回 "value"。 |
| `{{ foo['my-key'] }}` | 使用下標標記法存取帶有特殊字元的屬性，例如使用 `foo['my-key']` 而不是 `foo.my-key`。 |
| `{{ "Hello #{who}" }}` | 字面值中的字串插值，例如，如果 `who = "World"`，則返回 "Hello World"。 |


### 了解更多連結 (Links to learn more)

* 遵循分步 [教學 (tutorial)](https://kestra.io/docs/tutorial)
* 查看 [文件 (documentation)](https://kestra.io/docs)
* 在 [Kestra 的 YouTube 頻道](https://go.kestra.io/youtube-get-started) 上觀看 15 分鐘的關鍵概念視訊說明
* 在 [GitHub](https://github.com/kestra-io/kestra/issues/new/choose) 上提交功能請求或錯誤回報
* 需要幫助？[加入社群](https://kestra.io/slack)
* 喜歡這個專案嗎？在 [GitHub](https://github.com/kestra-io/kestra) 上給我們一個 ⭐️。
