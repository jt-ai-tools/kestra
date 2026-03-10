# 儀表板即程式碼 (Custom Dashboards as Code)

建立自定義儀表板來追蹤工作流的 `executions` (執行)、`logs` (日誌) 和 `metrics` (指標)，並根據特定的命名空間或標籤進行篩選，顯示您感興趣的數據。

宣告式語法允許您將儀表板作為程式碼進行管理 —— 您可以將儀表板定義與您的流程一起進行版本控制。

## 範例

以下是一個儀表板定義範例，顯示：
- 隨時間變化的 **executions** (執行) **時間序列 (time series)**
- 每個命名空間聚合的特定 **metrics** (指標) **表格 (table)**
- 按日誌級別和命名空間聚合的 **logs** (日誌) **表格 (table)**。

```yaml
title: Getting Started
description: First custom dashboard
timeWindow:
  default: P7D
  max: P365D
charts:
  - id: executions_timeseries
    type: io.kestra.plugin.core.dashboard.chart.TimeSeries
    chartOptions:
      displayName: Executions
      description: Executions last week
      legend:
        enabled: true
      column: date
      colorByColumn: state
    data:
      type: io.kestra.plugin.core.dashboard.data.Executions
      columns:
        date:
          field: START_DATE
          displayName: Date
        state:
          field: STATE
        total:
          displayName: Executions
          agg: COUNT
          graphStyle: BARS
        duration:
          displayName: Duration
          field: DURATION
          agg: SUM
          graphStyle: LINES

  - id: table_metrics
    type: io.kestra.plugin.core.dashboard.chart.Table
    chartOptions:
      displayName: Sum of sales per namespace
    data:
      type: io.kestra.plugin.core.dashboard.data.Metrics
      columns:
        namespace:
          field: NAMESPACE
        value:
          field: VALUE
          agg: SUM
      where:
        - field: NAME
          type: EQUAL_TO
          value: sales_count
        - field: NAMESPACE
          type: IN
          values:
            - dev_graph
            - prod_graph
      orderBy:
        - column: value
          order: DESC

    - id: table_logs
    type: io.kestra.plugin.core.dashboard.chart.Table
    chartOptions:
      displayName: Log count by level for filtered namespace
    data:
      type: io.kestra.plugin.core.dashboard.data.Logs
      columns:
        level:
          field: LEVEL
        count:
          agg: COUNT
      where:
        - field: NAMESPACE
          type: IN
          values:
            - dev_graph
            - prod_graph
```

更多範例請查看我們的 [GitHub 存儲庫](https://github.com/kestra-io/enterprise-edition-examples) 並探索儀表板藍圖 (Dashboard Blueprints)。

## 查詢數據

圖表的 `data` 屬性定義了查詢的數據類型。`type` 決定了顯示哪些列。

儀表板可以從以下來源 `types` 查詢數據：
- `type: io.kestra.plugin.core.dashboard.data.Executions`: 與您的工作流執行相關的數據
- `type: io.kestra.plugin.core.dashboard.data.Logs`: 執行產生的日誌
- `type: io.kestra.plugin.core.dashboard.data.Metrics`: 執行期間發出的指標。

定義數據源後，請指定要在圖表中顯示的 **columns** (列)。每一列都由 `field` 定義，並可能包含其他選填屬性。

| 屬性 | 描述 |
| --- |----------------------------------------------------------------------------------------------------------------|
| `field` | 唯一必填欄位，指定數據源中要使用的列名稱 |
| `displayName` | 設置圖表中顯示的標籤 |
| `agg` | 定義應用於該列的聚合函數：支援的聚合包括 `AVG` (平均值), `COUNT` (計數), `MAX` (最大值), `MIN` (最小值), `SUM` (總和) |
| `graphStyle` | 指示顯示的圖形樣式：支援的樣式包括 `LINES` (線條), `BARS` (長條), `POINTS` (點) |
| `columnAlignment` | 指定表格中列的對齊方式：支援的對齊方式包括 `LEFT` (左), `RIGHT` (右), `CENTER` (置中) |


您還可以使用 `where` 屬性設置過濾條件，在圖表中顯示結果集之前對其進行過濾。過濾器可以應用於數據源中的任何列。對於共享邏輯，請在 `where` 屬性中使用 `AND` 運算符組合多個條件。如果需要使用不同邏輯的多個條件，請使用 `type: OR` 屬性。

可用的過濾器類型包括：
- `CONTAINS` (包含)
- `ENDS_WITH` (以...結束)
- `EQUAL_TO` (等於)
- `GREATER_THAN` (大於)
- `GREATER_THAN_OR_EQUAL_TO` (大於或等於)
- `IN` (在...之中)
- `IS_FALSE` (為偽)
- `IS_NOT_NULL` (不為空)
- `IS_NULL` (為空)
- `IS_TRUE` (為真)
- `LESS_THAN` (小於)
- `LESS_THAN_OR_EQUAL_TO` (小於或等於)
- `NOT_EQUAL_TO` (不等於)
- `NOT_IN` (不在...之中)
- `OR` (或)
- `REGEX` (正規表達式)
- `STARTS_WITH` (以...開始)。

可用欄位類型 include the following columns:
- `ATTEMPT_NUMBER` (嘗試次數)
- `DATE` (日期)
- `DURATION` (持續時間)
- `END_DATE` (結束日期)
- `EXECUTION_ID` (執行 ID)
- `FLOW_ID` (流程 ID)
- `FLOW_REVISION` (流程修訂版本)
- `ID`
- `LABELS` (標籤)
- `LEVEL` (級別)
- `MESSAGE` (訊息)
- `NAME` (名稱)
- `NAMESPACE` (命名空間)
- `START_DATE` (開始日期)
- `STATE` (狀態)
- `TASK_ID` (任務 ID)
- `TASK_RUN_ID` (任務執行 ID)
- `TRIGGER_ID` (觸發器 ID)
- `TYPE` (類型)
- `VALUE` (值)。

請注意，上述某些內容僅保留給特定類型的 `data`。例如，`LEVEL` 列僅適用於 `type: io.kestra.plugin.core.dashboard.data.Logs`。
