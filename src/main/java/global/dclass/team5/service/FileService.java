package global.dclass.team5.service;

import java.io.File;			

import java.text.SimpleDateFormat;				
import java.util.Date;				
				
import org.springframework.web.multipart.MultipartFile;				
				
/**				
* 파일 관련 유틸				
* 업로드한 파일의 저장 & 서버에 저장된 파일 삭제 등의 기능 제공				
*/				
public class FileService {				
				

	public static String saveFile(MultipartFile mfile, String uploadPath) {			
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {		
			return null;	
		}		
				
		File path = new File(uploadPath);		
		if (!path.isDirectory()) {
			path.mkdirs();
		}		
				
		String originalFilename = mfile.getOriginalFilename();
				
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String savedFilename = sdf.format(new Date());
				
		String ext;		
		int lastIndex = originalFilename.lastIndexOf('.');		
		if (lastIndex == -1) {		
			ext = "";	
		}		
		else {		
			ext = "." + originalFilename.substring(lastIndex + 1);	
		}		
				
		File serverFile = null;		
				
		while (true) {		
			serverFile = new File(uploadPath + "/" + savedFilename + ext);	
			if ( !serverFile.isFile()) break;	
			savedFilename = savedFilename + new Date().getTime();	
		}		
				
		try {
			mfile.transferTo(serverFile);	
		} catch (Exception e) {		
			savedFilename = null;	
			e.printStackTrace();	
		}		
				
		return savedFilename + ext;		
	}			
				
	public static boolean deleteFile(String fullpath) {			
		boolean result = false;		
				
		File delFile = new File(fullpath);		
				
		if (delFile.isFile()) {		
			delFile.delete();	
			result = true;	
		}		
				
		return result;		
	}			
}				