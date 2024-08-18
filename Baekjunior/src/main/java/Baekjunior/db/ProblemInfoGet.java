package Baekjunior.db;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONArray;
import org.json.JSONObject;

public class ProblemInfoGet {
	private static final String SOLVED_AC_API_BASE_URL = "https://solved.ac/api/v3/problem/show?problemId=";
	private int[] arr = new int[31];
	private String tier_name = "";
	private int tier_num = 0;
	
	public ProblemInfoGet(){
		// 각 level 에 해당하는 level_num 저장 
		arr[0] = 0;
		int n = 5;
		for(int i=1; i<31; ++i) {
			arr[i] = n;
			--n;
			if(n == 0) {
				n = 5;
			}
		}
	}
	
	public String getAlgorithms(String problem_id) {
		try {
            // API URL 설정
            String urlString = SOLVED_AC_API_BASE_URL + problem_id;
            URL url = new URL(urlString);
            
            // HTTP 요청 생성 및 전송
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            // 응답 코드 확인
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
            }

            // 응답 데이터 읽기
            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
            StringBuilder sb = new StringBuilder();
            String output;
            while ((output = br.readLine()) != null) {
                sb.append(output);
            }

            // 연결 종료
            conn.disconnect();

            // JSON 응답 파싱
            JSONObject jsonResponse = new JSONObject(sb.toString());
            JSONArray tags = jsonResponse.getJSONArray("tags");

            // 알고리즘 분류를 저장할 리스트
            String[] classifications = new String[tags.length()];

            // 분류 정보 추출
            for (int i = 0; i < tags.length(); i++) {
                JSONObject tag = tags.getJSONObject(i);
                JSONArray displayNames = tag.getJSONArray("displayNames");
                JSONObject displayNameObj = displayNames.getJSONObject(0); // 첫 번째 언어 (예: 영어)
                classifications[i] = displayNameObj.getString("name");
            }
            	
            String s = "";
            for(int i = 0; i < classifications.length; i++) {
            	s += classifications[i] + ",";
            }
            return s;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}
	
	public String getTitle(String problem_id) {
		try {
			String urlString = SOLVED_AC_API_BASE_URL + problem_id;
            URL url = new URL(urlString);
            
            // HTTP 요청 생성 및 전송
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            // 응답 코드 확인
            if (conn.getResponseCode() == 404) {  // 문제가 존재하지 않는 경우
                return "not_found";
            }
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
            }

            // 응답 데이터 읽기
            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
            StringBuilder sb = new StringBuilder();
            String output;
            while ((output = br.readLine()) != null) {
                sb.append(output);
            }
            JSONObject jsonResponse = new JSONObject(sb.toString());
            String title = jsonResponse.getString("titleKo");
            
            return title;            
		}
		catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}
	
	public int getLevel(String problem_id) {
		try {
			String urlString = SOLVED_AC_API_BASE_URL + problem_id;
            URL url = new URL(urlString);
            
            // HTTP 요청 생성 및 전송
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            // 응답 코드 확인
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
            }

            // 응답 데이터 읽기
            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
            StringBuilder sb = new StringBuilder();
            String output;
            while ((output = br.readLine()) != null) {
                sb.append(output);
            }
            JSONObject jsonResponse = new JSONObject(sb.toString());     
            int level = jsonResponse.getInt("level");
            
            tier_num = arr[level];	// 티어 숫자
            
            // 티어 이름
            if(level == 0) {
            	tier_name = "unrated";
            }
            else if(0<level && level<=5) {
            	tier_name = "Bronze";
            }
            else if(level<=10) {
            	tier_name = "Silver";
            }
            else if(level<=15) {
            	tier_name = "Gold";
            }
            else if(level<=20) {
            	tier_name = "Platinum";
            }
            else if(level<=25) {
            	tier_name = "Diamond";
            }
            else {
            	tier_name = "Ruby";
            }
            return level;
		}
		catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
	}
	
	public String getProblemURL(String problem_id) {
		return "https://www.acmicpc.net/problem/" + problem_id;
	}
	
	public String getTierName() {
		return tier_name;
	}
	
	public int getTierNum() {
		return tier_num;
	}
}