package com.app;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    // application.propertiesから'spring.datasource.url'の値を読み込む
    // 環境変数が設定されていない場合のデフォルト値として "Not Set" を指定
    @Value("${spring.datasource.url:Not Set}")
    private String dbUrl;

    @Value("${spring.datasource.username:Not Set}")
    private String dbUsername;

    /**
     * アプリケーションのルートエンドポイント
     */
    @GetMapping("/")
    public String hello() {
        return "Hello, World! Application is running.";
    }

    /**
     * DB接続情報が環境変数から正しく読み込まれているかを確認するためのエンドポイント
     */
    @GetMapping("/db-config")
    public ResponseEntity<Map<String, String>> getDbConfig() {
        Map<String, String> dbConfig = new HashMap<>();
        dbConfig.put("DATABASE_URL", dbUrl);
        dbConfig.put("DATABASE_USERNAME", dbUsername);
        // 注意: パスワードはセキュリティのためレスポンスに含めません

        return ResponseEntity.ok(dbConfig);
    }
    
}
