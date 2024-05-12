package grad.member.service;

import java.io.InputStream;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import io.minio.BucketExistsArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;

@Service
public class FileUploadServiceImpl implements FileUploadServiceIF {
    
    private final MinioClient minioClient;
    private final String bucketName;

    public FileUploadServiceImpl(MinioClient minioClient,@Value("${minio.bucket.name}")String bucketName) {
    	this.bucketName=bucketName;
        this.minioClient = minioClient;
    }

    @Override
    public void uploadFile(String fileName, MultipartFile file) {
        try {
            // 버킷 존재 여부 확인
            boolean bucketExists = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
            if (!bucketExists) {
                throw new RuntimeException("Bucket does not exist: " + bucketName);
            } else {
                // 버킷 존재 시 로그 출력
                System.out.println("Bucket exists: " + bucketName);
            }

            try (InputStream fileInputStream = file.getInputStream()) {
                // 파일 업로드
                minioClient.putObject(
                        PutObjectArgs.builder().bucket(bucketName).object(fileName).stream(fileInputStream, -1, 104857600)
                                .contentType(file.getContentType())
                                .build());
                // 파일 업로드 성공 로그
                System.out.println("File uploaded successfully. 파일: " + fileName + ", 버켓: " + bucketName);
            }
        } catch (Exception e) {
            // 예외 발생 시 로그 출력
            System.out.println("File upload failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
