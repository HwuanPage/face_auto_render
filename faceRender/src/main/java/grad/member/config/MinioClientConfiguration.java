package grad.member.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.minio.MinioClient;

@Configuration
public class MinioClientConfiguration {

    @Value("${minio.URL}")
    private String url;

    @Value("${minio.port}")
    private int port;

    @Value("${minio.useSSL}")
    private boolean useSSL;

    @Value("${minio.accessKey}")
    private String accessKey;

    @Value("${minio.secretKey}")
    private String secretKey;

    @Bean
    public MinioClient minioClient() {
        return MinioClient.builder()
                .endpoint(url, port, useSSL)
                .credentials(accessKey, secretKey)
                .build();
    }
}
