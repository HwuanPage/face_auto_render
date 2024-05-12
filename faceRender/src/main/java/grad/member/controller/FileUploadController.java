package grad.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import grad.member.service.FileUploadServiceIF;


@Controller
public class FileUploadController {
	
	private final FileUploadServiceIF fileUploadServiceIF;
	
	public FileUploadController(FileUploadServiceIF fileUploadServiceIF) {
		this.fileUploadServiceIF= fileUploadServiceIF;
	}
	
	
	@GetMapping("/")
	public String showMainPage() {
		return "main/main-page";
	}

	@PostMapping("/upload")
	public ModelAndView uploadFile(@RequestParam("file") MultipartFile file) {
		ModelAndView mav = new ModelAndView("main/result-page");
		String fileName= file.getOriginalFilename();
		String contentType= file.getContentType();
		
		if (contentType != null && (contentType.equals("image/jpeg")||contentType.equals("image/jpeg")
				|| contentType.equals("image/png"))) {
            try {
                fileUploadServiceIF.uploadFile(fileName, file);
                mav.addObject("message", "파일 업로드 성공: " + fileName);
                System.out.println("성공: 파일 이름 - " + fileName + ", 파일 형식 - " + contentType);
                
            } catch (Exception e) {
                mav.addObject("message", "파일 업로드 실패: " + fileName);
                System.out.println("실패");
            }
        } else {
            mav.addObject("message", "허용되지 않는 파일 형식: " + fileName);
            System.out.println("실패: 허용되지 않는 파일 형식 - " + contentType);
        }
		return mav;
		
	}
}
