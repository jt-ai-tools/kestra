# JMH-Benchmarks 模組

此模組包含使用 OpenJDK 的 JMH 編寫的基準測試 (benchmarks)。

## 執行基準測試 (Running Benchmarks)

**執行所有基準測試**

```bash
./gradlew jmh
```

**執行特定的基準測試**

```bash
./gradlew jmh -Pjmh.include=io.kestra.core.utils.MapUtilsBenchmark
```
