package grad.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import grad.member.service.MinioServiceIF;
import jakarta.servlet.http.HttpServletResponse;
@Controller
public class FileController {

	MinioServiceIF minioServiceIF;
	public FileController(MinioServiceIF minioServiceIF) {
		this.minioServiceIF=minioServiceIF;
	}
	@GetMapping("/")
	public String showMainPage() {
		return "main/main";
	}
	
	@PostMapping("/upload")
	public ModelAndView uploadFile(@RequestParam("file") List<MultipartFile> file) {
		ModelAndView mav = new ModelAndView("main/loading-page");
		int count=1;
		List<MultipartFile> filelist = new ArrayList<MultipartFile>();
		for (int i=0;i<count;i++) {
			String fileName=file.get(i).getOriginalFilename();
			String contentType= file.get(i).getContentType();
			if (contentType != null && (contentType.equals("image/jpeg")||contentType.equals("image/jpeg")
					|| contentType.equals("image/png"))) {
	            mav.addObject("fileName"+Integer.toString(i),fileName);
	        } else {
	            mav.addObject("error","허용되지 않는 파일형식입니다.");
	        }
			minioServiceIF.uploadFile(fileName, file.get(i));
			mav.addObject("objectPath"+Integer.toString(i),"user1/rendering/"+Integer.toString(i)+"/");
		}
		return mav;
	}
	
	@GetMapping("/check-file-exists")
	@ResponseBody
	public Map<String,Boolean> checkFileExists(@RequestParam("objectPath")String objectPath){
		boolean fileExists = minioServiceIF.doesObjectExist(objectPath);
		Map<String,Boolean> response = new HashMap<>();
		response.put("fileExists",fileExists);
		return response;
	}
	@GetMapping("/result")
	public String showResultPage() {
		return "main/result-page";
	}
	@GetMapping("/download")
	public void downloadFile(@RequestParam(value="objectPath",required = false)String objectPath,HttpServletResponse response) {
		try {
	        byte[] file = minioServiceIF.downloadFile("user1/rendering/0/");
	        
	        // 파일 다운로드를 위한 응답 헤더 설정
	        response.setContentType("application/octet-stream");
	        response.setHeader("Content-Disposition", "attachment; filename=\"processed.ply\"");
	        response.setContentLength(file.length);

	        // 파일을 응답 출력 스트림에 작성
	        response.getOutputStream().write(file, 0, file.length);
	        response.getOutputStream().flush();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
}
