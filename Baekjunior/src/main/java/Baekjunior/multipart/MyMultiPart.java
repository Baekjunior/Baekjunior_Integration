package Baekjunior.multipart;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import jakarta.servlet.http.Part;


public class MyMultiPart {
	private Map<String, MyPart> fileMap;
	
	public MyMultiPart(Collection<Part> parts, String realFolder) throws IOException {
		fileMap = new HashMap<>();
		
		for(Part part: parts) {
			String fileName = part.getSubmittedFileName();
			
			if(fileName != null && fileName.length() != 0) {
				String fileDotExt = fileName.substring(fileName.lastIndexOf("."), fileName.length());
				UUID uuid = UUID.randomUUID();
				String savedFileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_" + uuid.toString() + fileDotExt;
				part.write(realFolder + File.separator + savedFileName);
				
				MyPart mp = new MyPart(part, savedFileName);
				fileMap.put(part.getName(), mp);
				
				part.delete();
			}
		}
	}
	
	public MyPart getMyPart(String paramName) {
		return fileMap.get(paramName);
	}
	
	public String getSavedFileName(String paramName) {
		return fileMap.get(paramName).getSavedFileName();
	}
	public String getOriginalFileName(String paramName) {
		return this.getMyPart(paramName).getPart().getSubmittedFileName();
	}
}
