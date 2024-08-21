package Baekjunior.multipart;

import jakarta.servlet.http.Part;

public class MyPart {
	private Part part;
	private String savedFileName;
	
	public MyPart(Part part, String savedFileName) {
		this.part = part;
		this.savedFileName = savedFileName;
	}
	
	public Part getPart() {
		return part;
	}
	public String getSavedFileName() {
		return savedFileName;
	}
}