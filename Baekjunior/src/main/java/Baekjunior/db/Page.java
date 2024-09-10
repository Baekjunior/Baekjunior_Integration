package Baekjunior.db;

public class Page {
	int totListSize; //검색된 결과의 전체 건수
	int totPage;
	int listSize=20;
	int blockSize=5;
	int startNo;
	int endNo;
	int startPage;
	int endPage;
	
	int nowPage=1;
	String findStr ="";
	
	public Page() {}
	public Page(int tot, int now) {
		this.totListSize = tot;
		this.nowPage = now;
		pageCompute();
	}
	
	//페이지와 관련된 모든 변수 계산
	public void pageCompute() {
		totPage = (int)Math.ceil(totListSize/(double)listSize);
		endNo = nowPage * listSize;
		startNo = endNo-listSize+1;
		
		if(endNo>totListSize) endNo = totListSize;
		
		endPage = (int)Math.ceil(nowPage/(double)blockSize) * blockSize;
		startPage = endPage-blockSize+1;
		
		if(endPage>totPage) endPage = totPage;
		
	}
	
	public int getStartPage() { return startPage; }
	public void setStartPage(int startPage) { this.startPage = startPage; }
	public int getEndPage() { return endPage; }
	public void setEndPage(int endPage) { this.endPage = endPage; }
	public int getTotListSize() { return totListSize; }
	public void setTotListSize(int totListSize) { this.totListSize = totListSize; }
	public int getTotPage() { return totPage; }
	public void setTotPage(int totPage) { this.totPage = totPage; }
	public int getListSize() { return listSize; }
	public void setListSize(int listSize) { this.listSize = listSize; }
	public int getNowPage() { return nowPage; }
	public void setNowPage(int nowPage) { this.nowPage = nowPage; }
	public int getStartNo() { return startNo; }
	public void setStartNo(int startNo) { this.startNo = startNo; }
	public int getEndNo() { return endNo; }
	public void setEndNo(int endNo) { this.endNo = endNo; }
	public String getFindStr() { return findStr; }
	public void setFindStr(String findStr) { this.findStr = findStr; }
	public int getBlockSize() { return blockSize; }
	public void setBlockSize(int blockSize) { this.blockSize = blockSize; }

}