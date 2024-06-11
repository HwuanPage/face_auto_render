package grad.member.service;

import java.io.IOException;
import java.io.InputStream;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import io.minio.BucketExistsArgs;
import io.minio.GetObjectArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.errors.MinioException;
@Service
public class MinioServiceImpl implements MinioServiceIF{
	private MinioClient minioClient;
    private String bucketName;
    private String objectName="geometry.ply";
    public MinioServiceImpl(MinioClient minioClient,@Value("${minio.bucket.name}")String bucketName) {
    	this.bucketName=bucketName;
    	this.minioClient=minioClient;
    }
    @Override
    public void uploadFile(String fileName, MultipartFile file) {
        try {
            // 버킷 존재 여부 확인
            boolean bucketExists = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
            if (!bucketExists) {
            	System.out.println("bucket does not exists"+bucketName);
            } else {
                // 버킷 존재 시 로그 출력
                System.out.println("Bucket exists: " + bucketName);
            }

            try (InputStream fileInputStream = file.getInputStream()) {
                // 파일 업로드
                minioClient.putObject(
                        PutObjectArgs.builder().bucket(bucketName).object("user1/images/"+fileName).stream(fileInputStream, -1, 104857600)
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
    public boolean doesObjectExist(String objectPath) {
    	System.out.println("받는 데이터(시작)"+bucketName+"오브젝트"+objectName);
    	try {
    		InputStream inputStream = minioClient.getObject(
    				GetObjectArgs.builder()
    				.bucket(bucketName)
    				.object(objectPath+objectName)
    				.build());
            return inputStream != null;
    	}catch (MinioException | IOException | NoSuchAlgorithmException | InvalidKeyException e) {
            return false;
    	}
    }
    public byte[] downloadFile(String objectPath) {
	    try {
	    	return minioClient.getObject(
	    			GetObjectArgs.builder()
	    			.bucket(bucketName)
	    			.object(objectPath+objectName)
	    			.build()).readAllBytes();
	    }catch (MinioException | IOException | NoSuchAlgorithmException | InvalidKeyException e) {
	           return null;
    	}
    }
}
