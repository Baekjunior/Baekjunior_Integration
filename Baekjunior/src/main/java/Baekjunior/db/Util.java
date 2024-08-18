package Baekjunior.db;

public class Util {
	public static String nullchk(String str) {
		return nullChk(str, "");
	}
	
	public static String nullChk(String str, String newstr) {
		if(str == null) 
			return newstr;
		else 
			return str;
	}
}
