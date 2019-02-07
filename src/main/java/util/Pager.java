package util;

public class Pager {
	
	public static int getMyTotalPage(int total) {
		return (int) Math.ceil(total / 5.0);
	}
	
	public static String myBoardPaging(int page, int total) {
		int totalPage = (int) Math.ceil(total / 5.0);
		
		StringBuffer sb = new StringBuffer();
		
				//왼쪽화살표
				if(page <= 1) {
					sb.append("<li class='disabled'>");
					sb.append("<a>");
					sb.append("<span class='glyphicon glyphicon-chevron-left'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}else {
					sb.append("<li>");
					sb.append("<a href='?page="+(page-1)+"'>");
					sb.append("<span class='glyphicon glyphicon-chevron-left'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}
				
				//시작페이지, 끝페이지
				int startPage = page - (page-1) % PAGES;
				int endPage = startPage + PAGES -1;
				if(endPage > totalPage) {
					endPage = totalPage;
				}
				
				for(int i = startPage; i <= endPage; i++) {
					if(i == page) {
						sb.append(
						 "<li class='active'><a>"+i+"</a></li>");
					}else {
						sb.append("<li>");
						sb.append("<a href='?page="+i+"'>"+i+"</a>");
						sb.append("</li>");
					}
				}
		
				//오른쪽화살표
				if(page >= totalPage) {
					sb.append("<li class='disabled'>");
					sb.append("<a>");
					sb.append("<span class='glyphicon glyphicon-chevron-right'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}else {
					sb.append("<li>");
					sb.append("<a href='?page="+(page+1)+"'>");
					sb.append("<span class='glyphicon glyphicon-chevron-right'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}
		
		return sb.toString();
	}
	
	
	//한 페이지에 뿌려줄 게시물 리스트의 수
	public static final int BOARDS = 15;
	//한 페이지에 뿌려줄 페이지 버튼의 수
	public static final int PAGES = 5;
	
	public static int getTotalPage(int total) {
		return (int)Math.ceil(total / (double)BOARDS);
	}
	
	public static String paging(int page, int total) {
		
		int totalPage = (int)Math.ceil(total / (double)BOARDS);
		
		StringBuffer sb = new StringBuffer();
		
				//맨첫페이지로
				if(page <= 1) {
					sb.append("<li class='disabled'>");
					sb.append("<a>");
					sb.append("<span class='glyphicon glyphicon-fast-backward'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}else {
					sb.append("<li>");
					sb.append("<a href='?page="+1+"'>");
					sb.append("<span class='glyphicon glyphicon-fast-backward'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}
				
				//왼쪽화살표
				if(page <= 1) {
					sb.append("<li class='disabled'>");
					sb.append("<a>");
					sb.append("<span class='glyphicon glyphicon-chevron-left'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}else {
					sb.append("<li>");
					sb.append("<a href='?page="+(page-1)+"'>");
					sb.append("<span class='glyphicon glyphicon-chevron-left'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}
				
				//시작페이지, 끝페이지
				int startPage = page - (page-1) % PAGES;
				int endPage = startPage + PAGES - 1;
				if(endPage > totalPage) {
					endPage = totalPage;
				}
				
				for(int i = startPage; i <= endPage; i++) {
					if(i == page) {
						sb.append(
						 "<li class='active'><a>"+i+"</a></li>");
					}else {
						sb.append("<li>");
						sb.append("<a href='?page="+i+"'>"+i+"</a>");
						sb.append("</li>");
					}
				}
		
				//오른쪽화살표
				if(page >= totalPage) {
					sb.append("<li class='disabled'>");
					sb.append("<a>");
					sb.append("<span class='glyphicon glyphicon-chevron-right'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}else {
					sb.append("<li>");
					sb.append("<a href='?page="+(page+1)+"'>");
					sb.append("<span class='glyphicon glyphicon-chevron-right'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}
				//맨끝페이지로
				if(page >= totalPage) {
					sb.append("<li class='disabled'>");
					sb.append("<a>");
					sb.append("<span class='glyphicon glyphicon-fast-forward'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}else {
					sb.append("<li>");
					sb.append("<a href='?page="+totalPage+"'>");
					sb.append("<span class='glyphicon glyphicon-fast-forward'></span>");
					sb.append("</a>");
					sb.append("</li>");
				}
		
		return sb.toString();
	}
	
}
