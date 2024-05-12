package grad.member.service;

import java.nio.file.Path;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadServiceIF {
	public void uploadFile(String fileName,MultipartFile file);
}
