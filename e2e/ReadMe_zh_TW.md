# 使用 Playwright 進行端對端測試 (End-to-End Testing)

此目錄包含 Kestra UI 的端對端 (E2E) 測試，使用 [Playwright](https://playwright.dev/) 構建。

## 設定

1.  安裝相依套件：
```bash
npm install
```

2.  安裝 Playwright 瀏覽器：

```bash
npx playwright install
```

## 配置

在 `kestra/ui/tests/e2e` 目錄中建立 `.env` 檔案，以配置測試目標和憑證。

`.env` 內容範例：

```env
KESTRA_UI_E2E_BASE_URL=http://localhost:5731
KESTRA_UI_E2E_USERNAME=admin
KESTRA_UI_E2E_PASSWORD=password
```

若要對您的本地 Kestra 實例執行測試，請以開發模式啟動 Kestra 並使用您在本地設置的憑證。

## 執行測試

### 執行所有測試

```bash
npm run test:e2e-without-starting-backend
```

### 以 UI 模式執行測試

這會開啟一個互動式 UI 來瀏覽和執行測試。

```bash
npm run test:e2e-without-starting-backend --ui
```

### 執行特定的測試檔案

```bash
npm run test:e2e-without-starting-backend tests/e2e/your-test-file.spec.ts
```
