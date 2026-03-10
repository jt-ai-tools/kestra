歡迎來到程式碼編輯器！

嵌入式程式碼編輯器讓您可以輕鬆地將自定義腳本、查詢和設定檔與您的流程 YAML 設定檔一起添加。

從選擇一個命名空間 (namespace) 開始。如果您輸入一個尚不存在的命名空間名稱，Kestra 將在執行時為您建立它。

然後，添加一個新檔案，例如一個 Python 腳本。嘗試添加一個名為 `scripts` 的資料夾，以及一個名為 `hello.py` 的檔案，內容如下：

```python
print("Hello from the Editor!")
```

添加檔案後，您就可以在流程中使用它。嘗試添加一個名為 `hello.yml` 的新流程，內容如下：

```yaml
id: hello
namespace: ${namespace}

tasks:
  - id: hello
    type: io.kestra.plugin.scripts.python.Script
    script: "{{ read('scripts/hello.py') }}"
```

最後，點擊「執行」 (Execute) 按鈕來執行您的流程。您應該會在日誌中看到親切的訊息 ``Hello from the Editor!``。

有關程式碼編輯器的更多資訊，請參閱[文件](https://kestra.io/docs/developer-guide/namespace-files)。
