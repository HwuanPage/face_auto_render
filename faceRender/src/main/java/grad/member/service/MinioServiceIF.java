package grad.member.service;

import java.io.InputStream;

import org.springframework.web.multipart.MultipartFile;

public interface MinioServiceIF {
	public void uploadFile(String fileName,MultipartFile file);
	public boolean doesObjectExist(String objectPath);
	public byte[] downloadFile(String objectPath);
}
