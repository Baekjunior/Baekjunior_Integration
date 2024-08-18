package Baekjunior.db;

public class ProblemInfo {
	private int problem_idx;
	private String user_id;
	private int problem_id;
	private String problem_title;
	private String problem_url;
	private String tier_name;
	private int tier_num;
	private int level;
	private String code;
	private String language;
	private int is_checked;
	private int is_fixed;
	private String main_memo;
	private String sub_memo;
	
	public int getProblem_idx() {
		return problem_idx;
	}
	public void setProblem_idx(int problem_idx) {
		this.problem_idx = problem_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getProblem_id() {
		return problem_id;
	}
	public void setProblem_id(int problem_id) {
		this.problem_id = problem_id;
	}
	public String getProblem_title() {
		return problem_title;
	}
	public void setProblem_title(String problem_title) {
		this.problem_title = problem_title;
	}
	public String getProblem_url() {
		return problem_url;
	}
	public void setProblem_url(String problem_url) {
		this.problem_url = problem_url;
	}
	public String getTier_name() {
		return tier_name;
	}
	public void setTier_name(String tier_name) {
		this.tier_name = tier_name;
	}
	public int getTier_num() {
		return tier_num;
	}
	public void setTier_num(int tier_num) {
		this.tier_num = tier_num;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	int getIs_checked() {
		return is_checked;
	}
	public void setIs_checked(int is_checked) {
		this.is_checked = is_checked;
	}
	public int getIs_fixed() {
		return is_fixed;
	}
	public void setIs_fixed(int is_fixed) {
		this.is_fixed = is_fixed;
	}
	public String getMain_memo() {
		return main_memo;
	}
	public void setMain_memo(String main_memo) {
		this.main_memo = main_memo;
	}
	public String getSub_memo() {
		return sub_memo;
	}
	public void setSub_memo(String sub_memo) {
		this.sub_memo = sub_memo;
	}
}
